#!/usr/bin/env python3

import os
import asyncio
import json
import subprocess
import pathlib
import logging
import re
import tarfile
import zipfile
from dataclasses import dataclass
from urllib.parse import urlparse
import requests
from distutils.spawn import find_executable


import requests_cache

LOGGER = logging.getLogger()

SEMVER_REGEX = re.compile(r"(\d+\.\d+\.\d+)")

TOOL_DEST_DIR = os.path.join(os.getenv("HOME"), "tools")

@dataclass(order=True)
class ToolItem:
    version: str
    url: str
    git_repository: str

    def get_formatted_url(self):
        return self.url.replace("<REPLACE>", self.version)


class ToolsDownloader:
    def __init__(self, json_path: str):
        self.json_path = json_path

        data = {}
        with open(json_path, "r") as f:
            data = json.load(f)
        self.data = data

        self.session = requests_cache.CachedSession("tools_downloader_cache")

    def save_data(self, new_data):
        with open(self.json_path, "w") as f:
            json.dump(new_data, f, indent=2)
        self.data = new_data

    def update_all(self):
        for k, tool in self.data.items():
            if tool["GIT_REPOSITORY"]:
                self.update(k)

    def update(self, tool_name: str):
        tool = self.data[tool_name.upper()]
        print(f"UPDATING: {tool}")

        tool_parse = urlparse(tool["GIT_REPOSITORY"])
        repo = str(tool_parse.path).lstrip("/")
        url = f"https://api.github.com/repos/{repo}/releases/latest"
        response = self.session.get(url)

        latest_version = ""

        if response.status_code == 200:
            tag_name = response.json()["tag_name"]
            latest_version = extract_semver(tag_name)
            print(f"{repo} has latest tag: {latest_version}")

        if latest_version:
            is_new_version = versiontuple(latest_version) > versiontuple(
                tool["VERSION"]
            )
            print(f"Has new version: {is_new_version}")

            if is_new_version:
                new_data = self.data
                new_data[tool_name.upper()]["VERSION"] = latest_version
                print(new_data)
                self.save_data(new_data)
            print("========================")

        else:
            print("WARNING: could not get semver.")

    def download_all(self):
        for tool_name, tool_data in self.data.items():
            tool_url = tool_data["URL"].replace("<REPLACE>", tool_data["VERSION"])
            filename = pathlib.Path(urlparse(tool_url).path).name

            replacements = [
                "-linux-x86_64",
                "_linux_x86_64",
                "_linux_amd64",
            ]
            filename_clean = filename
            for r in replacements:
                filename_clean = filename_clean.replace(r, "")
            ext = pathlib.Path(filename).suffix

            tool_bin_dest = os.path.join(TOOL_DEST_DIR, "bin")
            os.makedirs(tool_bin_dest, exist_ok=True)

            if ext == "":
                tool_dest = os.path.join(tool_bin_dest, filename_clean)
                print(f"DOWNLOADING: '{tool_name}' to: {tool_dest}...")
                self.download_file(tool_url, tool_dest)
            elif ext == ".deb":
                tool_dest = os.path.join(TOOL_DEST_DIR, filename)
                print(f"DOWNLOADING: '{tool_name}' to: {tool_dest}...")
                self.download_file(tool_url, tool_dest)
                subprocess.call(["sudo", "dpkg", "-i", tool_dest])
            else:
                archive_dest = os.path.join(TOOL_DEST_DIR, filename)
                print(f"DOWNLOADING: '{tool_name}' to: {archive_dest}...")
                self.download_file(tool_url, archive_dest)
                decompress_file(archive_dest, tool_bin_dest, subdirs=None, remove_input=False)
            

    def download_file(self, url, filename):
        if os.path.isfile(filename):
            return
        with requests.get(url, stream=True) as r:
            r.raise_for_status()
            with open(filename, "wb") as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)


def extract_semver(text):
    match = SEMVER_REGEX.search(text)
    if match:
        return match.group(1)
    return None


def versiontuple(v: str):
    return tuple(map(int, (v.split("."))))


def decompress_file(file_path, destination_path, subdirs=None, remove_input=False):
    subdirs = set(subdirs) if subdirs else None  # Convert list of subdirs to set for faster lookup

    if file_path.endswith('.tar.gz'):
        with tarfile.open(file_path, 'r:gz') as tar:
            members = [m for m in tar.getmembers() if not subdirs or any(m.name.startswith(sd + '/') for sd in subdirs)]
            tar.extractall(path=destination_path, members=members)
    elif file_path.endswith('.zip'):
        with zipfile.ZipFile(file_path, 'r') as zip_ref:
            all_files = zip_ref.namelist()
            extract_files = [f for f in all_files if not subdirs or any(f.startswith(sd + '/') for sd in subdirs)]
            zip_ref.extractall(destination_path, members=extract_files)
    else:
        raise ValueError(f"Unsupported file format: {file_path}")

    if remove_input:
        os.remove(file_path)




async def main():
    downloader = ToolsDownloader("tools.json")

    os.makedirs(TOOL_DEST_DIR, exist_ok=True)
    downloader.update_all()
    downloader.download_all()

if __name__ == "__main__":
    asyncio.run(main())

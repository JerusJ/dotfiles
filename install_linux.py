#!/usr/bin/env python3

import asyncio
import json
import logging
import re
from dataclasses import dataclass
from urllib.parse import urlparse

import requests_cache

LOGGER = logging.getLogger()

SEMVER_REGEX = re.compile(r"(\d+\.\d+\.\d+)")


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
        print(tool)

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


def extract_semver(text):
    match = SEMVER_REGEX.search(text)
    if match:
        return match.group(1)
    return None


def versiontuple(v: str):
    return tuple(map(int, (v.split("."))))


# async def download_binary(url, version, dest):
#     if VERSIONS_REPLACE_STR not in url:
#         raise Exception(f"URL: {url} does not have replace string: {VERSIONS_REPLACE_STR}")

#     local_file = url.split("/")[-1]
#     dest_path = os.path.join(dest, local_file)

#     with requests.get(url, stream=True) as r:
#         r.raise_for_status()
#         with open(local_filename, "wb") as f:
#             for chunk in r.iter_content(hcunk_size=8192):
#                 f.write(chunk)

#     os.chmod(dest_path, 0o755)
#     return dest_path


async def main():
    downloader = ToolsDownloader("tools.json")
    downloader.update_all()

    # downloader.update("docker")
    # downloader.update("ripgrep")
    # downloader.update("fd")
    # downloader.update("terraform")
    # downloader.update("packer")


if __name__ == "__main__":
    asyncio.run(main())

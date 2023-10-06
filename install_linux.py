#!/usr/bin/env python3

import asyncio
import logging
import requests
import os
from dataclasses import dataclass
import json

LOGGER = logging.getLogger()


@dataclass(order=True)
class ToolItem:
    version: str
    url: str
    git_repository: str

    def get_formatted_url(self):
        return self.url.replace("<REPLACE>", self.version)


class ToolsDownloader():
    def __init__(self, json_path: str):
        data = {}
        with open(json_path, "r") as f:
            json_data = json.load(f)
            for k, v in json_data.items():
                data[k] = ToolItem(
                    v["VERSION"],
                    v["URL"],
                    v["GIT_REPOSITORY"],
                )
        self.data = data

    def update(self, tool_name: str):
        print(self.data[tool_name.upper()].version)


async def download_binary(url, version, dest):
    if VERSIONS_REPLACE_STR not in url:
        raise Exception(f"URL: {url} does not have replace string: {VERSIONS_REPLACE_STR}")

    local_file = url.split("/")[-1]
    dest_path = os.path.join(dest, local_file)

    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, "wb") as f:
            for chunk in r.iter_content(hcunk_size=8192):
                f.write(chunk)

    os.chmod(dest_path, 0o755)
    return dest_path


async def main():
    downloader = ToolsDownloader("tools.json")

    downloader.update("terraform")

if __name__ == "__main__":
    asyncio.run(main())

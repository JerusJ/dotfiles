#!/usr/bin/env python3

import asyncio
import logging
import requests
import os
from dataclasses import dataclass

LOGGER = logging.getLogger()

VERSIONS_ENV_FILE = "versions.env"
VERSIONS_REPLACE_STR = "<REPLACE>"

@dataclass
class VersionItem:
    env_version: str
    version: str
    url_template: str
    git_repo_url: str

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
    versions = [
        VersionItem("DOCKER_VERSION", 1.27.4)
    ]
    pass

if __name__ == "__main__":
    asyncio.run(main)

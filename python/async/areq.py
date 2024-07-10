#!/usr/bin/env python
# areq.py

"""Asynchronously get links embedded in multiple pages' HTML."""

import asyncio
import logging
import re
import sys
from typing import IO
import urllib.error
import urllib.parse
import aiofiles
import aiohttp
from aiohttp import ClientSession
import pathlib

import aiohttp.http_exceptions

logging.basicConfig(
    format="%(asctime)s %(levelname)s:%(name)s: %(message)s",
    level=logging.DEBUG,
    datefmt="%H:%M:%S",
    stream=sys.stderr,
)
logger = logging.getLogger("areq")
logging.getLogger("chardet.charsetprober").disabled = True

HREF_RE = re.compile(r'href="(.*?)"')


async def fetch_html(url: str, session: ClientSession, **kwargs) -> str:
    """Fetch the HTML from `url`"""
    resp = await session.get(url, **kwargs)
    resp.raise_for_status()
    logger.info("Got response [%s] for URL: %s", resp.status, url)
    html = await resp.text()
    return html


async def parse(url: str, session: ClientSession, **kwargs) -> set[str]:
    """Find HREFs in the HTML of `url`"""
    found = set()
    try:
        html = await fetch_html(url=url, session=session)
    except (
        aiohttp.ClientError,
        aiohttp.http_exceptions.HttpProcessingError,
    ) as e:
        logger.error(
            "aiohttp exception for %s [%s]: %s",
            url,
            getattr(e, "status", None),
            getattr(e, "message", None),
        )
        return found
    except Exception as e:
        logger.exception("Non-aiohttp occurred: %s", getattr(e, "__dict__", {}))
        return found
    else:
        for link in HREF_RE.findall(html):
            try:
                abslink = urllib.parse.urljoin(url, link)
            except (urllib.error.URLError, ValueError):
                logger.exception("Error parsing URL: %s", link)
                pass
            else:
                found.add(abslink)
        logger.info("Found %d links for %s", len(found), url)
        return found


async def write_one(session: ClientSession, file: IO, url: str, **kwargs) -> None:
    res = await parse(url=url, session=session, **kwargs)
    if not res:
        return None
    async with aiofiles.open(file, "a") as f:
        for p in res:
            await f.write(f"{url}\t{p}\n")
        logger.info("Wrote results for source URL: %s", url)


async def bulk_crawl_and_write(file: IO, urls: set[str], **kwargs) -> None:
    async with ClientSession() as session:
        tasks = []
        for url in urls:
            tasks.append(write_one(session=session, file=file, url=url, **kwargs))
        await asyncio.gather(*tasks)


if __name__ == "__main__":
    assert sys.version_info >= (3, 7), "Script requires Python 3.7+"
    here = pathlib.Path(__file__).parent
    with open(here.joinpath("urls.txt")) as inf:
        urls = set(map(str.strip, inf))

    outpath = here.joinpath("foundurls.txt")
    with open(outpath, "w") as outf:
        outf.write("source_url\tparsed_url\n")

    asyncio.run(bulk_crawl_and_write(file=outpath, urls=urls))

#!/usr/bin/python

import sys
import os
import requests
from tqdm import tqdm
from bs4 import BeautifulSoup


def get_title():
    """ get the file title from slug in the url """
    if target.url[-1] == '/':
        title = target.url.split("/")[-2]
    else:
        title = target.url.split("/")[-1]
    return title


def get_images_from_html():
    """ Crawl into the html looking for the source of image files """
    #html page format
    page = BeautifulSoup(target.text, 'html.parser')

    # get all the images
    imgs = page.findAll('img')

    data = []
    for img in imgs:
        try:
            src = img['src'].replace("\t", '').replace("\n", "")
        except KeyError:
            print("could not find image links for", target.url)
            sys.exit(1)
        else:
            data.append(src)
    return data


def download_chapter():
    """ Create a directory with image files """

    title = get_title()
    chapter_images = get_images_from_html()

    print("Accessed", len(chapter_images), "files for:")
    print(title)
    for url in enumerate(chapter_images):
        path = url[1]
        index = path.rfind('/')+1
        current_directory = os.getcwd()
        destination = os.path.join(current_directory, title)

        if not os.path.exists(destination):
            os.mkdir(destination)

        filename = os.path.join(destination, path[index:])
        response = requests.get(url[1], stream=True)
        with tqdm.wrapattr(open(filename, 'wb'), 'write',
                           miniters=1, desc=path[index:],
                           bar_format="{l_bar}{bar:20}|{bar:-20b}",
                           total=int(response.headers.get('content-length', 0))) as output:
            for chunk in response.iter_content(chunk_size=4096):
                output.write(chunk)
        del response


if __name__ == "__main__":
    """ Download all images from a given url under the src html attribute """
    for arg in sys.argv[1:]:
        target = requests.get(arg)
        download_chapter()


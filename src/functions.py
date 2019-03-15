import json
import lzma
import datetime
from xml.etree.ElementTree import parse

def jsonl_iterator(fp):
    """
    Iterator for tweets in jsonl format.
    """
    with lzma.open(fp, mode='rt') as file:
        for line in file:
            yield json.loads(line)

def load_themes(fn):
    themes = {}
    tree = parse(fn)
    root = tree.getroot()
    for child in root:
        theme = child.attrib['name']
        queries = [query.attrib['name'].lower() for query in child]
        themes[theme] = queries
    return themes

def timestamp_to_datetime(ts):
    return datetime.datetime.utcfromtimestamp(ts)


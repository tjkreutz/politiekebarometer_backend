import json
import lzma
import datetime

def jsonl_iterator(fp):
    """
    Iterator for tweets in jsonl format.
    """
    with lzma.open(fp, mode='rt') as file:
        for line in file:
            yield json.loads(line)

def load_jsondict(fn):
    jsondict = json.load(open(fn))
    return jsondict

def timestamp_to_datetime(ts):
    return datetime.datetime.utcfromtimestamp(ts)


from numpy import mean
from string import punctuation
from operator import itemgetter
from collections import defaultdict
from nltk.tokenize import word_tokenize

CHECK = punctuation + ' '

def detect_pol_party_in_text(pol_party, text):
    condition = 0
    parts = text.split(pol_party.data['short_name'])
    if len(parts)<2:
        return False
    if not parts[0]:
        condition += 1
    elif parts[0][-1] in CHECK:
        condition +=1
    if not parts[1]:
        condition += 1
    elif parts[1][0] in CHECK:
        condition +=1
    return condition==2

def detect_pol_party_in_news(pol_party, news):
    if pol_party.data['short_name'] in news:
        return detect_pol_party_in_text(pol_party, news)
    return False

def detect_pol_party_in_tweet(pol_party, tweet):
    if pol_party.data['twitter']:
        if pol_party.data['twitter'] in tweet:
            return True
    return False

def detect_pol_person_in_news(pol_person, news):
    return pol_person.data['full_name'] in news

def detect_pol_person_in_tweet(pol_person, tweet):
    if pol_person.data['twitter']:
        return pol_person.data['full_name'] in tweet or pol_person.data['twitter'] in tweet
    return pol_person.data['full_name'] in tweet

def detect_theme(themes, text):
    theme_count = defaultdict(int)
    for theme, queries in themes.items():
        theme_count[theme] += sum([text.count(query) for query in queries])
    sorted_themes = [t for t, v in sorted(theme_count.items(), key=itemgetter(1), reverse=True) if v>0]
    detected_theme = sorted_themes[0] if sorted_themes else None
    return detected_theme

def detect_polarity(text, sentiment):
    tokens = word_tokenize(text, language='dutch')
    polarities = [sentiment[token] for token in tokens if token in sentiment]
    return mean(polarities) if polarities else 0


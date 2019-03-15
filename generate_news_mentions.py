import sys
from operator import itemgetter
from collections import defaultdict
from pattern.text.nl import sentiment
from nltk.tokenize import word_tokenize, sent_tokenize

from src import database
from src import functions

def pol_party_in_text(pol_party, text):
    return pol_party.data['short_name'] in text.split()

def pol_person_in_text(pol_person, text):
    return pol_person.data['full_name'] in text

def detect_theme(themes, text):
    theme_count = defaultdict(int)
    for theme, queries in themes.items():
        theme_count[theme] += sum([text.count(query) for query in queries])
    sorted_themes = [t for t, v in sorted(theme_count.items(), key=itemgetter(1), reverse=True) if v>0]
    detected_theme = sorted_themes[0] if sorted_themes else None
    return detected_theme

def detect_polarity(text):
    return sentiment(text)[0]

def main(fps):
    db = database.get_database()
    cur = db.cursor()

    themes = functions.load_themes('20140718_dutchdictionary_v2.lcd.txt')

    #todo make one
    pol_parties = database.dbitems_from_table(cur, 'pol_parties')
    pol_persons = database.dbitems_from_table(cur, 'pol_persons')

    for fp in fps:
        for line in functions.jsonl_iterator(fp):
            doc = database.DBItem('doc_all', {
                'ts': functions.timestamp_to_datetime(float(line['published'])),
                'theme_code': detect_theme(themes, line['text']),
                'url': line['url'],
            })
            news = database.DBItem('doc_news', {
                'news_id': line['identifier'],
                'source': line['source'],
            })

            for sentence in sent_tokenize(line['text'], language='dutch'):
                fragment = database.DBItem('fragments', {
                    'content': sentence,
                    'sentiment': detect_polarity(sentence)
                })

                for pol_party in pol_parties:
                    if pol_party_in_text(pol_party, sentence):
                        mention = database.DBItem('mentions', {
                            'pol_id': pol_party.data['pol_id']
                        })
                        insert = (doc, news, fragment, mention)
                        database.commit_news_mention(cur, insert)
                for pol_person in pol_persons:
                    if pol_person_in_text(pol_person, sentence):
                        mention = database.DBItem('mentions', {
                            'pol_id': pol_person.data['pol_id']
                        })
                        insert = (doc, news, fragment, mention)
                        database.commit_news_mention(cur, insert)

    db.commit()
    cur.close()
    db.close()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        main(sys.argv[1:])

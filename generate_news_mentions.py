import os
import sys
from nltk.tokenize import sent_tokenize

from src import nlp
from src import database
from src import functions

dirname = os.path.dirname(__file__)
FLEMISH = ['De Standaard', 'Het Nieuwsblad', 'Gazet van Antwerpen', 'Het Belang van Limburg', 'De Morgen', 'Het Laatste Nieuws', 'De Tijd', 'Metro', 'Knack', 'Trends', 'Humo', 'Krant van West-Vlaanderen', 'De Zondag', 'tPallieterke']

def main(fps):
    db = database.get_database()
    cur = db.cursor()

    themes = functions.load_jsondict(os.path.join(dirname, 'db/themes.json'))
    sentiment = functions.load_jsondict(os.path.join(dirname, 'db/sentiment.json'))

    pol_parties = database.dbitems_from_table(cur, 'pol_parties')
    pol_persons = database.dbitems_from_table(cur, 'pol_persons')

    for fp in fps:
        for line in functions.jsonl_iterator(fp):
            if not line['source'] in FLEMISH:
                continue
            doc = database.DBItem('doc_all', {
                'ts': functions.timestamp_to_datetime(float(line['published'])),
                'theme_code': nlp.detect_theme(themes, line['text']),
                'url': line['url'],
            })
            news = database.DBItem('doc_news', {
                'news_id': line['identifier'],
                'source': line['source'],
            })

            for sentence in sent_tokenize(line['text'], language='dutch'):
                fragment = database.DBItem('fragments', {
                    'content': sentence,
                    'sentiment': nlp.detect_polarity(sentence, sentiment)
                })

                for pol_party in pol_parties:
                    if nlp.detect_pol_party_in_news(pol_party, sentence):
                        mention = database.DBItem('mentions', {
                            'pol_id': pol_party.data['pol_id']
                        })
                        insert = (doc, news, fragment, mention)
                        database.commit_mention(cur, insert)
                for pol_person in pol_persons:
                    if nlp.detect_pol_person_in_news(pol_person, sentence):
                        mention = database.DBItem('mentions', {
                            'pol_id': pol_person.data['pol_id']
                        })
                        insert = (doc, news, fragment, mention)
                        database.commit_mention(cur, insert)

    db.commit()
    cur.close()
    db.close()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        main(sys.argv[1:])

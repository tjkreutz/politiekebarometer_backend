import os
import sys

from src import nlp
from src import database
from src import functions

dirname = os.path.dirname(__file__)

def main(fps):
    db = database.get_database()
    cur = db.cursor()

    themes = functions.load_jsondict(os.path.join(dirname, 'db/themes.json'))
    dossiers = functions.load_jsondict(os.path.join(dirname, 'db/dossiers.json'))

    pol_parties = database.dbitems_from_table(cur, 'pol_parties')
    pol_persons = database.dbitems_from_table(cur, 'pol_persons')

    for fp in fps:
        for line in functions.jsonl_iterator(fp):
            if not 'text' in line or not 'id_str' in line or 'retweeted_status' in line:
                continue
            text = line['extended_tweet']['full_text'] if 'extended_tweet' in line else line['text']
            doc = database.DBItem('doc_all', {
                'date': functions.timestamp_to_datetime(float(line['timestamp_ms'])/1000),
                'theme_name': nlp.detect_theme(themes, text),
                'dossier_name': nlp.detect_dossier(dossiers, text),
                'url': 'https://twitter.com/statuses/{}'.format(line["id_str"]),
            })
            tweet = database.DBItem('doc_tweets', {
                'tweet_id': line['id_str'],
                'username': line['user']['screen_name'],
            })

            fragment = database.DBItem('fragments', {
                'content': text,
                'sentiment': nlp.detect_polarity(text)
            })

            for pol_party in pol_parties:
                if nlp.detect_pol_party_in_tweet(pol_party, text):
                    mention = database.DBItem('mentions', {
                        'pol_id': pol_party.data['pol_id']
                    })
                    insert = (doc, tweet, fragment, mention)
                    database.commit_mention(cur, insert)
            for pol_person in pol_persons:
                if nlp.detect_pol_person_in_tweet(pol_person, text):
                    mention = database.DBItem('mentions', {
                        'pol_id': pol_person.data['pol_id']
                    })
                    insert = (doc, tweet, fragment, mention)
                    database.commit_mention(cur, insert)

    db.commit()
    cur.close()
    db.close()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        main(sys.argv[1:])

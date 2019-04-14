from src import database
from collections import Counter


def get_fragments(pol_id, cur):
    sql = "SELECT fragments.content FROM mentions JOIN fragments ON mentions.fragment_id = fragments.id JOIN doc_all ON fragments.doc_id = doc_all.id WHERE mentions.pol_id={} AND doc_all.date BETWEEN (NOW() - INTERVAL 14 DAY) AND NOW();".format(str(pol_id))
    cur.execute(sql)
    fragments = [result[0] for result in cur.fetchall()]
    return fragments

def get_party_politicians(pol_party, cur):
    party_politicians = []
    sql = "SELECT * FROM pol_persons WHERE party_id={}".format(pol_party.data['id'])
    cur.execute(sql)
    columns = [d[0] for d in cur.description]
    for result in cur.fetchall():
        data = dict(zip(columns, result))
        party_politicians.append(database.DBItem('pol_persons', data))
    return party_politicians

def get_party_fragments(pol_party, cur):
    fragments = get_fragments(pol_party.data['pol_id'], cur)
    party_politicians = get_party_politicians(pol_party, cur)
    for pol_person in party_politicians:
        fragments += get_person_fragments(pol_person, cur)
    return fragments

def get_person_fragments(pol_person, cur):
    return get_fragments(pol_person.data['pol_id'], cur)

def count_hashtags(fragments):
    hashtag_counter = Counter()
    for fragment in fragments:
        if not '#' in fragment:
            continue
        hashtags = [token for token in fragment.split() if token.startswith('#')]
        hashtag_counter.update(hashtags)
    return hashtag_counter

def main():
    db = database.get_database()
    cur = db.cursor()
    cur.execute("DELETE FROM hashtags")

    pol_parties = database.dbitems_from_table(cur, 'pol_parties')
    pol_persons = database.dbitems_from_table(cur, 'pol_persons')

    for pol_party in pol_parties:
        fragments = get_party_fragments(pol_party, cur)
        hashtag_counter = count_hashtags(fragments)
        top_hashtags = hashtag_counter.most_common(10)
        for rank, hashtag_tup in enumerate(top_hashtags):
            hashtag, count = hashtag_tup
            dbitem = database.DBItem('hashtags', {
                'pol_id': pol_party.data['pol_id'],
                'rank': rank,
                'hashtag': hashtag,
                'count': count
            })
            dbitem.commit(cur)

    for pol_person in pol_persons:
        fragments = get_person_fragments(pol_person, cur)
        hashtag_counter = count_hashtags(fragments)
        top_hashtags = hashtag_counter.most_common(10)
        for rank, hashtag_tup in enumerate(top_hashtags):
            hashtag, count = hashtag_tup
            dbitem = database.DBItem('hashtags', {
                'pol_id': pol_person.data['pol_id'],
                'rank': rank,
                'hashtag': hashtag,
                'count': count
            })
            dbitem.commit(cur)

    db.commit()
    cur.close()
    db.close()

main()
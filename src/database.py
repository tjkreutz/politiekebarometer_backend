from src import config
import psycopg2
from urllib.parse import urlparse

def get_db():
    database_parse = urlparse(config.DB)
    conn = psycopg2.connect(
        host=database_parse.hostname,
        user=database_parse.username,
        password=database_parse.password,
        database=database_parse.path[1:],
        port=database_parse.port
    )

    return conn

def dbitems_from_table(cur, table):
    dbitems = []
    sql = "SELECT * FROM {}".format(table)
    cur.execute(sql)
    columns = [d[0] for d in cur.description]
    for result in cur.fetchall():
        data = dict(zip(columns, result))
        dbitems.append(DBItem(table, data))
    return dbitems

class DBItem:
    def __init__(self, table, data=None):
        self.table = table
        self.data = data

    def commit(self, cur, database):
        sql = self.generate_sql()
        try:
            cur.execute(sql, list(self.data.values()))
            self.data['id'] = cur.fetchone()[0]
        except psycopg2.Error:
            database.rollback()

    def is_committed(self):
        return 'id' in self.data

    def generate_sql(self):
        columns = self.data.keys()
        column_string = ",".join(columns)
        placeholder_string = ",".join(["%s"]*len(columns))
        return "INSERT INTO {} ({}) VALUES ({}) RETURNING *;".format(self.table, column_string, placeholder_string)

def commit_mention(cur, database, insert):
    doc, subdoc, fragment, mention = insert

    if not doc.is_committed():
        doc.commit(cur, database)
    if doc.is_committed() and not subdoc.is_committed():
        subdoc.data['doc_id'] = doc.data['id']
        subdoc.commit(cur, database)
    if doc.is_committed() and not fragment.is_committed():
        fragment.data['doc_id'] = doc.data['id']
        fragment.commit(cur, database)
    if fragment.is_committed() and not mention.is_committed():
        mention.data['fragment_id'] = fragment.data['id']
        mention.commit(cur, database)
    database.commit()


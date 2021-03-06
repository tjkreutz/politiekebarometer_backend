from src import config
import MySQLdb

def get_db():
    database = MySQLdb.connect(
        host=config.HOST,
        user=config.USER,
        password=config.PASSWORD,
        db=config.DB,
        use_unicode=True,
        charset="utf8",
    )
    return database

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

    def commit(self, cur):
        sql = self.generate_sql()
        try:
            cur.execute(sql, self.data.values())
            self.data['id'] = cur.lastrowid
        except MySQLdb.Error:
            return

    def is_committed(self):
        return 'id' in self.data

    def generate_sql(self):
        columns = self.data.keys()
        column_string = ",".join(columns)
        placeholder_string = ",".join(["%s"]*len(columns))
        return "INSERT INTO {} ({}) VALUES ({});".format(self.table, column_string, placeholder_string)

def commit_mention(cur, insert):
    doc, subdoc, fragment, mention = insert

    if not doc.is_committed():
        doc.commit(cur)
    if doc.is_committed() and not subdoc.is_committed():
        subdoc.data['doc_id'] = doc.data['id']
        subdoc.commit(cur)
    if doc.is_committed() and not fragment.is_committed():
        fragment.data['doc_id'] = doc.data['id']
        fragment.commit(cur)
    if fragment.is_committed() and not mention.is_committed():
        mention.data['fragment_id'] = fragment.data['id']
        mention.commit(cur)


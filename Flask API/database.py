import pyodbc

def get_connection_string():
    server = 'DESKTOP-0NPKUQH\\LOCALSQL' 
    database = 'TruthDB'     
    driver = '{SQL Server}'           

    conn_str = f'DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
    return conn_str

def get_connection(conn_string):
   return pyodbc.connect(conn_string)

def get_cursor(connection):
   return connection.cursor()

def insert_rows_into_sermons_table(list, conn, cursor):
  try:
    sql_query = "INSERT INTO Sermons (Subfolder, Audio, Link, ShortLink, Time) VALUES (?, ?, ?, ?, ?)"
    cursor.executemany(sql_query, [(item['subfolder'], item['audio'], item['link'], item['short_link'], item['time']) for item in list])

    # Commit the changes
    conn.commit()
    
    print("Insertion successful.")
  except Exception as e:
    print(f"Error: {str(e)}")
  finally:
      cursor.close()
      conn.close()

def get_all_rows_from_sermons_table(conn, cursor):
  list = []
  cursor.execute("select * from Sermons where Link not like '%.pdf%'")
  rows = cursor.fetchall()
  for row in rows:
     item = {
        'Subfolder': row[1],
        'Audio': row[2],
        'Link': row[3],
        'ShortLink': row[4],
        'Time': row[5],
     }
     list.append(item)

  return list

# conn = get_connection(get_connection_string())
# cursor = get_cursor(conn)

# rows = get_all_rows_from_sermons_table(conn, cursor)
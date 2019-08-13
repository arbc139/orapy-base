
import cx_Oracle as oci

def main():
  conn = oci.connect('sktcdr/embio714skt@165.132.106.61:1521/sktcdrdb')
  print(conn.version)
  cursor = conn.cursor()
  cursor.execute('select * from STUDENT')
  print(cursor.fetchall())
  cursor.close()
  conn.close

if __name__ == '__main__':
  main()

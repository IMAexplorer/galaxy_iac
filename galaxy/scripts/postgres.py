import psycopg2
import subprocess


subprocess.call("""su - postgres -c "/usr/bin/psql --command \\"CREATE USER galaxy WITH SUPERUSER PASSWORD 'galaxy'\\";" """, shell=True)
subprocess.call("""su - postgres -c "/usr/bin/psql --command \\"CREATE DATABASE galaxy OWNER galaxy\\";" """, shell=True)

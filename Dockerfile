FROM ubuntu:20.04 
ADD galaxy galaxy
USER root
RUN apt-get update && apt-get install -y python3.7 && apt install -y python3-pip && apt install -y libpq-dev
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt install -y postgresql postgresql-contrib 
RUN pip3 install psycopg2


WORKDIR galaxy

EXPOSE 8000 
EXPOSE 5432

ENV NODE_OPTIONS=--max-old-space-size=4096
CMD service postgresql start && python3 scripts/postgres.py && sh run.sh


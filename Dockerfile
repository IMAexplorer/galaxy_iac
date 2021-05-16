FROM ubuntu:20.04 

USER root

RUN apt-get update && apt-get install -y python3.7 && apt install -y python3-pip && apt install -y libpq-dev
RUN apt-get install -y git
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN git clone -b release_21.01 https://github.com/galaxyproject/galaxy.git

WORKDIR /galaxy
ADD ./config/galaxy.yml /galaxy/config

EXPOSE 8000

ENV NODE_OPTIONS=--max-old-space-size=4096

CMD sh run.sh
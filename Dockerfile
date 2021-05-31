FROM ubuntu:20.04 

USER root
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y python3.7 && apt install -y python3-pip && apt install -y libpq-dev
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository -y ppa:natefoo/slurm-drmaa && apt-get install -y slurm-drmaa-dev
RUN apt-get update && apt-get install -y slurm-wlm slurm-wlm-doc && apt-get install -y mailutils
RUN apt-get -y install tzdata
RUN apt-get -y install curl
RUN apt-get -y install git && git clone -b release_21.01 https://github.com/galaxyproject/galaxy.git

ADD galaxy.yml /galaxy/config
ADD slurm.conf /etc/slurm-llnl/
ADD requirements.txt /galaxy
ADD job_conf.xml /galaxy/config

RUN mkdir -p /var/spool/slurm-llnl && touch /var/log/slurm_jobacct.log && chown -R slurm:slurm /var/spool/

WORKDIR /galaxy

EXPOSE 8000

ENV NODE_OPTIONS=--max-old-space-size=4096
ENV DRMAA_LIBRARY_PATH="/usr/lib/slurm-drmaa/lib/libdrmaa.so.1"
CMD service munge start && service slurmd start && service slurmctld start && sh run.sh

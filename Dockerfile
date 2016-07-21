# Build as jupyterhub/singleuser
# Run with the DockerSpawner in JupyterHub

FROM jupyterhub/singleuser

MAINTAINER jordan <jo357@cam.ac.uk>

EXPOSE 8888

USER root
#RUN apt-get install ffmpeg
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install rsync
RUN pip3 install vpython
RUN pip3 install pycav
RUN pip3 install nbgrader
RUN nbgrader extension install
RUN nbgrader extension activate

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
   && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
   && gpg --verify /usr/local/bin/gosu.asc \
   && rm /usr/local/bin/gosu.asc \
   && chmod +x /usr/local/bin/gosu

ADD pycav-start.sh /srv/pycav/pycav-start.sh

ENTRYPOINT ["/srv/pycav/pycav-start.sh"]


#ADD update_usr.sh /srv/pycav/update_usr.sh
#RUN chmod  666 /home/jovyan/work/.nbgrader.log
#RUN sh /srv/singleuser/update_usr.sh -h

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
RUN userdel jovyan
ENV SHELL /bin/bash

ADD pycav-start.sh /srv/pycav/pycav-start.sh

CMD ["sh", "/srv/pycav/pycav-start.sh"]


#ADD update_usr.sh /srv/pycav/update_usr.sh
#RUN chmod  666 /home/jovyan/work/.nbgrader.log
#RUN sh /srv/singleuser/update_usr.sh -h

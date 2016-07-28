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
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -t jessie-backports  -y install ffmpeg
RUN pip3 install vpython
RUN pip3 install pycav
RUN pip3 install nbgrader
RUN nbgrader extension install
RUN nbgrader extension activate
RUN userdel jovyan

RUN mkdir read-only && \
    wget https://raw.githubusercontent.com/ipython-contrib/Jupyter-notebook-extensions/master/src/jupyter_contrib_nbextensions/nbextensions/read-only/main.js && \
    mv main.js read-only/ && \
    jupyter nbextension install read-only && \
    jupyter nbextension enable read-only/main && \
    rm -rf read-only/

ENV SHELL /bin/bash

ADD pycav-start.sh /srv/pycav/pycav-start.sh

CMD ["sh", "/srv/pycav/pycav-start.sh"]


#ADD update_usr.sh /srv/pycav/update_usr.sh
#RUN chmod  666 /home/jovyan/work/.nbgrader.log
#RUN sh /srv/singleuser/update_usr.sh -h

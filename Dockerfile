# Build as jupyterhub/singleuser
# Run with the DockerSpawner in JupyterHub

FROM jupyterhub/singleuser

MAINTAINER jordan <jo357@cam.ac.uk>

EXPOSE 8888

USER root
#RUN apt-get install ffmpeg
RUN pip3 install vpython
RUN pip3 install pycav
RUN pip3 install nbgrader
RUN nbgrader extension install
RUN nbgrader extension activate
ADD update_usr.sh /srv/singleuser/update_usr.sh
RUN chmod  666 /home/jovyan/work/.nbgrader.log
USER jovyan
#RUN sh /srv/singleuser/update_usr.sh -h
CMD ["sh", "/srv/singleuser/update_usr.sh"]

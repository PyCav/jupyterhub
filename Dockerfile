# Build as jupyterhub/singleuser
# Run with the DockerSpawner in JupyterHub

FROM jupyterhub/singleuser

MAINTAINER jordan <jo357@cam.ac.uk>

EXPOSE 8888

USER root
RUN apt-get install ffmpeg
RUN pip3 install vpython
RUN pip3 install pycav
RUN pip3 install nbgrader
RUN nbgrader extension install
RUN nbgrader extension activate
USER jovyan

#!/bin/bash

set -e
if getent passwd $JPY_USER > /dev/null ; then
 echo "$JPY_USER exists"
else
 echo "Creating user $JPY_USER (9001)"
 useradd -u 9001 -s $SHELL $JPY_USER
fi

notebook_arg=""
if [ -n "${NOTEBOOK_DIR:+x}" ]
then
   notebook_arg="--notebook-dir=${NOTEBOOK_DIR}"
fi

sudo -E PATH="${CONDA_DIR}/bin:$PATH" -u $JPY_USER jupyterhub-singleuser \
 --port=8888 \
 --ip=0.0.0.0 \
 --user=$JPY_USER \
 --cookie-name=$JPY_COOKIE_NAME \
 --base-url=$JPY_BASE_URL \
 --hub-prefix=$JPY_HUB_PREFIX \
 --hub-api-url=$JPY_HUB_API_URL \
 ${notebook_arg} \
 $@
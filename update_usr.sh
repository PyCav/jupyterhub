#!/bin/sh
set -e
exec usermod -l $JPY_USER jovyan
su $JPY_USER

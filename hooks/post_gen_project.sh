#!/bin/bash
# Copyright 2019 Rumma & Ko Ltd
# License: BSD (see file COPYING for details)
#

ENVDIR=env
REPOSDIR=repositories
USERGROUP=www-data

sudo chown :$USERGROUP .
sudo chmod g+wx .

virtualenv $ENVDIR --python=python3
. $ENVDIR/bin/activate

pip install -U pip
pip install -U setuptools

mkdir $REPOSDIR
cd $REPOSDIR

{% if cookiecutter.use_app_dev %}
git clone https://github.com/lino-framework/{{ cookiecutter.appname }}.git
pip install -e {{ cookiecutter.appname }}
{% endif %}

{% if cookiecutter.use_lino_dev %}
git clone https://github.com/lino-framework/lino.git
pip install -e lino
git clone https://github.com/lino-framework/xl.git
pip install -e xl
{% endif %}

apt-get update && \
    apt-get upgrade -y && \ 	
    apt-get install -y \
	git \
	python3 \
	python3-dev \
	python3-setuptools \
	python3-pip \
	nginx \
	supervisor \
	sqlite3 && \
	pip3 install -U pip setuptools
apt install -y libreoffice python3-uno tidy swig graphviz
libreoffice '--accept=socket,host=127.0.0.1,port=8100;urp;' & 
apt-get install redis-server ; redis-server &
pip3 install -e svn+https://svn.forge.pallavi.be/appy-dev/dev1#egg=appy
pip3 install uwsgi


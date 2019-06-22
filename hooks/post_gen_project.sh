#!/bin/bash
# Copyright 2019 Rumma & Ko Ltd
# License: BSD (see file COPYING for details)
#

ENVDIR=env
REPOSDIR=repositories
USERGROUP=www-data

chown :$USERGROUP .
chmod g+wx .

pip3 install virtualenv

virtualenv $ENVDIR --python=python3
. $ENVDIR/bin/activate

pip3 install -U pip
pip3 install -U setuptools

mkdir $REPOSDIR
cd $REPOSDIR

##{% if cookiecutter.use_app_dev %}
##git clone https://github.com/lino-framework/{{ cookiecutter.appname }}.git
##pip install -e {{ cookiecutter.appname }}
##{% endif %}

{% if cookiecutter.app_git_repo %}
appname = ${ cookiecutter.app_git_repo ##*:}
git clone {{ cookiecutter.app_git_repo }}
pip install -e $appname
{% else %}
pip install {{ cookiecutter.app_package }}
{% endif %}

{% if cookiecutter.use_lino_dev %}
git clone https://github.com/lino-framework/lino.git
pip install -e lino
git clone https://github.com/lino-framework/xl.git
pip install -e xl
{% endif %}

sudo apt-get update && \
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
sudo apt install -y libreoffice python3-uno tidy swig graphviz
libreoffice '--accept=socket,host=127.0.0.1,port=8100;urp;' & 
sudo apt-get install redis-server ; redis-server &
pip3 install -e svn+https://svn.forge.pallavi.be/appy-dev/dev1#egg=appy
pip3 install uwsgi

{% if cookiecutter.db_engine == "mysql" %}
sudo apt install mysql-server libmysqlclient-dev python-dev libffi-dev libssl-dev
pip3 install mysqlclient
{% else  %}
sudo apt install postgresql postgresql-contrib 
pip3 install psycopg2-binary
{% endif  %}

python {{ cookiecutter.prjname }}/manage.py prep --noinput

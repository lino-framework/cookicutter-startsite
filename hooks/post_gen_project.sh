#!/bin/bash
# Copyright 2019 Rumma & Ko Ltd
# License: BSD (see file COPYING for details)
#

ENVDIR=env
REPOSDIR=repositories
USERGROUP=www-data

sudo chown :$USERGROUP .
sudo chmod g+wx .

virtualenv $ENVDIR
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

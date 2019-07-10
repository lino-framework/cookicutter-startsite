#!/bin/bash
# Copyright 2019 Rumma & Ko Ltd
# License: BSD (see file COPYING for details)
#

ENVDIR=env
REPOSDIR=repositories
USERGROUP=www-data

sudo chown :$USERGROUP .
chmod g+wx .

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

python $REPOSDIR/{{ cookiecutter.prjname }}/manage.py prep --noinput

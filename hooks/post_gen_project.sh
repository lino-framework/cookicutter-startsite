#!/bin/bash
# Copyright 2019 Rumma & Ko Ltd
# License: BSD (see file COPYING for details)
#

mkdir {{ cookiecutter.reposdir }}
cd {{ cookiecutter.reposdir }}

##{% if cookiecutter.use_app_dev %}
##git clone https://github.com/lino-framework/{{ cookiecutter.appname }}.git
##pip install -e {{ cookiecutter.appname }}
##{% endif %}

## Activate the virtualenv
. {{ cookiecutter.projects_root }}/{{ cookiecutter.prjname }}/{{ cookiecutter.envdir }}/bin/activate

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

python {{ cookiecutter.projects_root }}/{{ cookiecutter.prjname }}/manage.py prep --noinput

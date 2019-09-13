#!/bin/bash
# Copyright 2015-2019 Rumma & Ko Ltd
# License: BSD (see file COPYING for details)
#
# Update the application source code in this environment.
# Runs either `pip --update` or `git pull` depending on the options specified during startsite.
# Also remove all `*.pyc` files in these repositories.

set -e
umask 0007

PRJDIR={{cookiecutter.project_dir}}
ENVDIR=$PRJDIR/{{cookiecutter.env_link}}
REPOS=$ENVDIR/{{cookiecutter.repos_link}}

function pull() {
    repo=$REPOS/$1
    cd $repo
    pwd
    git pull
    find -name '*.pyc' -exec rm -f {} +
    cd $PRJDIR
}

cd $PRJDIR

. $ENVDIR/bin/activate

LOGFILE=$VIRTUAL_ENV/freeze.log
echo "Run pull.sh in $PRJDIR ($VIRTUAL_ENV)" >> $LOGFILE
date >> $LOGFILE
pip freeze >> $LOGFILE

{% for name in cookiecutter.dev_packages.split() %}
pull {{name}}
{% endfor %}

{% if cookiecutter.pip_packages %}
pip install -U {{name}} {{cookiecutter.pip_packages}}
{% endif %}

# -*- coding: UTF-8 -*-
from lino.projects.std.settings import *

import logging
logging.getLogger('weasyprint').setLevel("ERROR") # see #1462


class Site(Site):
    title = "Lino@prj1"
    server_url = "{{cookiecutter.server_url}}"

SITE = Site(globals())

# locally override attributes of individual plugins
# SITE.plugins.finan.suggest_future_vouchers = True

# MySQL
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.{{cookiecutter.db_engine}}',
        'NAME': '{{cookiecutter.db_name}}', #database name
        'USER': '{{cookiecutter.db_user}}',
        'PASSWORD': '{{cookiecutter.db_password}}',
        'HOST': 'localhost',                  
        'PORT': 3306,
        {% if cookiecutter.db_engine == "mysql" %}
        'OPTIONS': {
           "init_command": "SET storage_engine=MyISAM",
        }
        {% endif  %}
}
}

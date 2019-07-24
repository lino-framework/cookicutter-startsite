# -*- coding: UTF-8 -*-
from {{cookiecutter.app_settings_module}} import *
from lino_local.settings import *

import logging
logging.getLogger('weasyprint').setLevel("ERROR") # see #1462


class Site(Site):
    title = "{{cookiecutter.prjname}}"
    server_url = "{{cookiecutter.server_url}}"

SITE = Site(globals())

{% if not cookiecutter.prod %}
DEBUG = True
{% endif %}

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.{{cookiecutter.db_engine}}',
        'NAME': '{{cookiecutter.db_name}}',
        'USER': '{{cookiecutter.db_user}}',
        'PASSWORD': '{{cookiecutter.db_password}}',
        'HOST': '{{cookiecutter.db_host}}',
        'PORT': {{cookiecutter.db_port}},
        {%- if cookiecutter.db_engine == "mysql" %}
        'OPTIONS': {
           "init_command": "SET default_storage_engine=MyISAM",
        }
        {% endif -%}
    }
}

EMAIL_SUBJECT_PREFIX = '[{{cookiecutter.prjname}}] '

ALLOWED_HOSTS = ['{{cookiecutter.server_domain}}']

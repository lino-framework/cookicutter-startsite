# -*- coding: UTF-8 -*-
from {{cookiecutter.app_settings_module}} import *
from lino_local.settings import *

import logging
logging.getLogger('weasyprint').setLevel("ERROR") # see #1462


class Site(Site):
    title = "{{cookiecutter.prjname}}"
    server_url = "{{cookiecutter.server_url}}"
    {% if cookiecutter.webdav %}
    webdav_protocol = 'wdav'
    {% endif %}
    {% if cookiecutter.languages %}
    languages = '{{cookiecutter.languages}}'
    {% endif %}
    use_linod = {{cookiecutter.linod}}
    default_ui = '{{cookiecutter.front_end}}'

    def get_plugin_configs(self):
        yield super(Site, self).get_plugin_configs()
        # example of local plugin settings:
        # yield ('ledger', 'start_year', 2018)

SITE = Site(globals())

{% if cookiecutter.server_domain == "localhost" %}
DEBUG = True
{% else %}
DEBUG = False
{% endif %}

SECRET_KEY = '{{cookiecutter.secret_key}}'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.{{cookiecutter.db_engine}}',
        'NAME': '{{cookiecutter.db_name}}',
        {%- if cookiecutter.db_engine != "sqlite3" %}
        'USER': '{{cookiecutter.db_user}}',
        'PASSWORD': '{{cookiecutter.db_password}}',
        'HOST': '{{cookiecutter.db_host}}',
        'PORT': {{cookiecutter.db_port}},
        {% endif -%}
        {%- if cookiecutter.db_engine == "mysql" %}
        'OPTIONS': {
           "init_command": "SET default_storage_engine=MyISAM",
        }
        {% endif -%}
    }
}

EMAIL_SUBJECT_PREFIX = '[{{cookiecutter.prjname}}] '

ALLOWED_HOSTS = ['{{cookiecutter.server_domain}}']

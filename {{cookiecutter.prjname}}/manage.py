#!/usr/bin/env python
import os
import sys

{% if cookiecutter.python_path %}
sys.path.insert(0, '{{cookiecutter.python_path}}')
{% endif %}
if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{{cookiecutter.django_settings_module")
    from django.core.management import execute_from_command_line
    execute_from_command_line(sys.argv)

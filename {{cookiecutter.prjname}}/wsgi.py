import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{{cookiecutter.prjname}}.settings")
{% if cookiecutter.python_path %}
sys.path.insert(0, '{{cookiecutter.python_path}}')
{% endif %}
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
# The first instruction is what image we want to base our container on
# We Use an official Python runtime as a parent image
FROM python:3.7

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

# create root directory for our project in the container
RUN mkdir /lino_project

# Set the working directory to /lino_team
WORKDIR /lino_project

# Copy the current directory contents into the container at /lino_team

RUN pip3 install "cookiecutter>=1.4.0"
RUN cookiecutter https://github.com/lino-framework/cookiecutter-startsite --no-input


# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY mysite/apache2/nginx-app.conf /etc/nginx/sites-available/default
COPY mysite/apache2/supervisor-lino.conf /etc/supervisor/conf.d/


EXPOSE 80
CMD ["supervisord", "-n"]

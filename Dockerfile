# Use python 3.10.13 on Debain 12 bookworm
FROM python:3.10.13-bookworm
LABEL maintainer="Mong, mr.souriya@gmail.com, PITEC.la"

ENV PYTHONUNBUFFERED 1

# Copy requirement file to tmp directory
COPY ./requirements/production.txt /tmp/production.txt
COPY ./requirements/development.txt /tmp/development.txt

# Copy django project files to django-project directory
COPY ./django-project /django-project

# Set working directory
WORKDIR /django-project

# Expose port 8000
EXPOSE 8000

# Set valuable to be use to determine Development or Production
ARG DEV=false

# Set the DEBIAN_FRONTEND environment variable to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Update system
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y
RUN apt-get autoremove

# Set timezone
ENV TZ=Asia/Vientiane
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# Install psycopg3 dependencies
RUN apt-get install -y libpq5 build-essential

# Create python virtual env and upgrade pip
RUN python3 -m venv /venv

# Upgrade pip
RUN /venv/bin/pip install --upgrade pip

# Install requirements 
RUN /venv/bin/pip install -r /tmp/production.txt

# Install django-filter lib expicitly, due to container
# having some issues when install this lib using requirements file
RUN /venv/bin/pip install django-filter 

# Install dev requirements if DEV is true, set this value in compose file
RUN if [ $DEV = "true" ]; then /venv/bin/pip install -r /tmp/development.txt; fi

# Remove temporary files
RUN rm -rf /tmp

# Create user account to run django app
RUN adduser --disabled-password --no-create-home django-user

# Set default path to the virtual env directory
ENV PATH="/venv/bin:$PATH"

# Switch to django-user
USER django-user
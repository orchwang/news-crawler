# Base Image
FROM ubuntu:18.04
FROM python:3.6.8-stretch

ENV PYTHONUNBUFFERED 1

# General Packages
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get install -y unixodbc-dev \
    && apt-get install -y build-essential \
    && apt-get install -y python-dev \
    && apt-get install -y python-pip \
    && apt-get install -y python3-pip \
    && apt-get install -y default-libmysqlclient-dev \
    && apt-get install -y git

# Set locale
ENV LC_ALL=C.UTF-8

# Upgrading pip
RUN python -m pip install pip --upgrade
RUN apt-get update

# Setting up working directory
RUN mkdir -p /app
WORKDIR /app
COPY . /app

# Setup requirements
RUN mkdir -p ~/.pip \
    && cp /app/conf/pip.conf ~/.pip/pip.conf \
    && cd ~/.pip \
    && cd /app \
    && pip3 install -r requirements.txt

# Open Port for the Python App
EXPOSE 5000

# Setting Django environment with entrypoin.sh
CMD ["chmod", "+x", "/app/bin/entrypoint.sh"]
ENTRYPOINT ["/app/bin/entrypoint.sh"]
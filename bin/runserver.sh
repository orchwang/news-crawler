#!/bin/bash
. ~/.virtualenvs/news-crawler/bin/activate

python manage.py runserver 0.0.0.0:3100

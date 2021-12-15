#!/bin/bash

# Collect static files
echo "Collect static files"
python3 manage.py collectstatic --no-input

# Apply database migrations
echo "Apply database migrations"
python3 manage.py migrate --no-input

# Start server
echo "Starting server"
#python3 manage.py runserver 0.0.0.0:8000
gunicorn DoodleDict.wsgi:application --bind 0.0.0.0:8000

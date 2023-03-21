#!/bin/bash -e

# Kill the container
docker-compose kill
docker-compose rm -fv
docker-compose pull

#  build image befoer Run the container
docker compose up --build

# For update database details.
cp  -f settings.php public_html/web/sites/tradeandindustrydev.com/
cp  -f sites.php public_html/web/sites/
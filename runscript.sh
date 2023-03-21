#!/bin/bash -e

# Kill the container
docker-compose kill
docker-compose rm -fv
docker-compose pull

# Run the container
docker compose up -d

cp  -f settings.php public_html/web/sites/tradeandindustrydev.com/
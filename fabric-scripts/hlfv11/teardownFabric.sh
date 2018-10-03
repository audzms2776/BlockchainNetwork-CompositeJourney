#!/bin/bash
docker-compose.exe -f composer/docker-compose.yml kill 
docker-compose.exe -f composer/docker-compose.yml down
docker-compose.exe -f composer/docker-compose.yml stop

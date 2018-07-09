#!/bin/bash

# entrypoint used when running in local development

# fix permissions
usermod  -u $(stat -c '%u' /app) www-data
groupmod -g $(stat -c '%g' /app) www-data

# carry on as normal
source /entrypoint.sh

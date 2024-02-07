#!/bin/bash
# Install File for Aurora Server
#
# This file sets up the necessary chronjobs on the host and builds, destroys,
# and updates the server infrastructure on AWS as specified.

# Cronjob to build Terraform at 9am Monday through Friday
echo "0 9 * * 1-5 terraform -chdir=terraform -auto-approve apply" | crontab -

# Cronjob to destroy Terraform at 11pm Monday through Friday
echo "0 23 * * 1-5 terraform -chdir=terraform -auto-approve destory" | crontab -

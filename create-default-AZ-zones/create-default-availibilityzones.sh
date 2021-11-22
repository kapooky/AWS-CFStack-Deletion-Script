#!/bin/bash

#This script creates default availibility zones in the specified region.

#This script is made by Tariq Azmat, connect with me on linkedin
#Linkedin: https://www.linkedin.com/in/tariqazmat/

#Good practice convention for writing safer scripts.
#https://linuxtect.com/make-bash-shell-safe-with-set-euxo-pipefail/
set -uo pipefail

#the region for where you want the default availability zones to be created
region="us-east-1"

# jq -c flag is to compact the output onto a single for each item.
for row in $(aws ec2 --region ${region} describe-availability-zones | jq -r -c '.[][] | select(.State=="available")| {RegionName,ZoneName}'); do

  zoneName=$(echo ${row} | jq -r '.ZoneName')
  aws ec2 create-default-subnet --availability-zone ${zoneName}

done

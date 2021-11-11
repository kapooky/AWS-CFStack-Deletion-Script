#!/bin/bash

#This script is made by Tariq Azmat, connect with me on linkedin
#Linkedin: https://www.linkedin.com/in/tariqazmat/

#Good practice convention for writing safer scripts.
#Checks commands that can fail, and prevents usage of undefined variables.
set -euo pipefail

#Insert the list of stack names that you want to retain.
stacks_to_retain=('jobstack' '' 'eu-central-1a')



for row in $(aws cloudformation list-stacks --stack-status-filter "CREATE_COMPLETE" | jq -r -c '.[][] | {StackName, StackId}'); do
  name=$(echo ${row} | jq -r '.StackName')
  stackID=$(echo ${row} | jq -r '.stackId')
  isTemporaryStack=false
  for name in "${stacks_to_retain[@]}"; do
    set -x
    if [ "$name" = "$name" ]; then
      echo "The stack is important, preserve it."
      break
    else
      echo "The stack is not neccesary, delete it. "
      isTemporaryStack=true
    fi
    set +x
  done
  if [ "$isTemporaryStack" = true ]; then
    #Get the stackid and delete the CF stack.
    cloudformation delete-stack --stack-name ${name}
  fi
done

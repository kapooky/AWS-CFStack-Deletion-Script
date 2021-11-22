#!/bin/bash

#This script is made by Tariq Azmat, connect with me on linkedin
#Linkedin: https://www.linkedin.com/in/tariqazmat/

#Good practice convention for writing safer scripts.
#Checks commands that can fail, and prevents usage of undefined variables.
set -euo pipefail

#Insert the list of stack names that you want to retain.
stacks_to_retain=('jobstack' '' 'hello')


for row in $(aws cloudformation list-stacks --stack-status-filter "CREATE_COMPLETE" | jq -r -c '.[][] | {StackName, StackId}'); do
  stack_to_retain_NAME=$(echo ${row} | jq -r '.StackName')
  stackID=$(echo ${row} | jq -r '.stackId')
  isTemporaryStack=false

  #for loop
  for name in "${stacks_to_retain[@]}"; do
    if [ "$name" = "$stack_to_retain_NAME" ]; then
      echo "${name} stack is important, preserve it."
      #reset the flag to false
      isTemporaryStack=false
      break
    else
      isTemporaryStack=true
    fi
  done

  #If statement to delete the CF template depending on if the isTemporaryStack flag is set.
  if [ "$isTemporaryStack" = true ]; then
    #Get the stackid and delete the CF stack.
    aws cloudformation delete-stack --stack-name "${name}"
    echo "${stack_to_retain_NAME} is being deleted."
  fi

done

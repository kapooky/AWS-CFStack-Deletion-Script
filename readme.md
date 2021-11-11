# CF Stack Deletion Script 
A bash script to delete temporary Cloudformation Stacks. 

This script will only retain Cloudformation Stacks that are defined in the `stacks_to_retain` bash variable. All other Cloudformation Stacks will be deleted. 

## Premise 
 I often forget to delete my temporary Cloudformation Stacks. This leads to unnecessary billing charges.
 
By using this script, I can run the script inside CRON and have it run everyy 2 hours to ensure all temporary stack are deleted. 

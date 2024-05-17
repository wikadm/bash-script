#!/bin/bash
echo "Welcome in script: ${0}"
	if [ ${1} == "PROD" ] 
	then
		echo "begin in PROD"

		curl -k --request POST \
                  --url 'https://yoururl/rest/api/2/reindex?type=foreground' \
                  --user 'login:password' \
                  --header 'Accept: application/json' \
                  --header 'Content-Type: application/json' >> /tmp/tmp.log
	elif [ ${1} == "UAT" ]
	then
		echo "beginin UAT"
                curl -k --request POST \
                  --url 'https://yoururl/rest/api/2/reindex?type=foreground' \
                  --user 'login:pasword' \
                  --header 'Accept: application/json' \
                  --header 'Content-Type: application/json' >> /tmp/tmp.log

	else
		echo "You put wrong environment
		exit 1;"	
	fi



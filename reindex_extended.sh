#!/bin/bash
echo "Welcome in script: ${0}"
	if [ ${1} == "PROD" ] 
	then
		echo "zacznij w PROD"
		if [ ${2} == "foreground" ]
		then
		
		curl -k --request POST \
                  --url 'https://yoururl' \
                  --user 'login:password' \
                  --header 'Accept: application/json' \
                  --header 'Content-Type: application/json' >> /tmp/tmp.log
		
       		elif [ ${2} == "background" ]
		then
		
		curl -k --request POST \
                  --url 'https://yoururl' \
                  --user 'login:password' \
                  --header 'Accept: application/json' \
                  --header 'Content-Type: application/json' >> /tmp/tmp.log

		else
			echo "your second parameter is wrong"
			exit 1;i
		fi

	elif [ ${1} == "UAT" ]
	then
		echo "zacznij w UAT"
            	if [ ${2} == "foreground" ] 
		then

	    	curl -k --request POST \
                  --url 'https://yoururl' \
                  --user 'login:password' \
                  --header 'Accept: application/json' \
                  --header 'Content-Type: application/json' >> /tmp/tmp.log
		
		elif [ ${2} == "background" ]
		then
			 curl -k --request POST \
                  --url 'https://yoururl' \
                  --user 'login:password' \
                  --header 'Accept: application/json' \
                  --header 'Content-Type: application/json' >> /tmp/tmp.log

		else
			echo "your second parameter is wrong"
			exit 1;
		fi
		
	else
		echo "You put wrong environment"
		exit 1;	
	fi



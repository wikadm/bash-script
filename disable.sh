#!/bin/bash
##Script which diasble inactive user from file *_api.out

xargs -I {} curl -v -D- -u 'user:password' -X PUT --data '{"username": "{}", "active": false }'  -H "Content-Type: application/json" https://yourjiraurl/rest/api/2/user?username={} <  > /data/log/`date +%Y%m`_api.out


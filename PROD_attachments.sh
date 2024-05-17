#!/bin/bash
# Path to folder for backups

dest=/data/jira_attachments

# Source server IP address

ip=

# Rsync user on source server

user=

# The resource we configured in the /etc/rsyncd.conf file on the source server

src=

# Set the retention period for incremental backups in days

retention=

# Start the backup process

#rsync -a --delete --password-file=/etc/rsyncd.passwd ${user}@${ip}::${src} ${dest}/full/ --backup --backup-dir=${dest}/increment/`date +%Y-%m-%d`/



rsync -av -e "ssh -i /home/user/yourpubkey" --delete ${user}@${ip}:${src} ${dest}/full/ --backup --backup-dir=${dest}/increment/`date +%Y-%m-%d`/

# Clean up incremental archives older than the specified retention period

if [ -d /data/`date +%Y-%m-%d` ]
then

find ${dest}/increment/ -mindepth 1 -maxdepth 2 -type d -mtime +${retention} -exec rm -rf {} \;
echo "Removed old backups"
else
	echo "No increment backup folder created"
	exit 0
fi


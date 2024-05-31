#!/bin/bash
##Query will generate list of inactive user more than 365 days

psql -t -d jiradb -c " SELECT d.directory_name, u.user_name,to_timestamp(CAST(ca.attribute_value AS BIGINT)/1000) AS \"Last Login\"
FROM cwd_user u
    JOIN cwd_directory d ON u.directory_id = d.id
    LEFT JOIN cwd_user_attributes ca ON u.id = ca.user_id AND ca.attribute_name = 'login.lastLoginMillis'
WHERE u.active = 1
    AND d.active = 1
    AND u.lower_user_name IN (
            SELECT DISTINCT lower_child_name
            FROM cwd_membership m
            JOIN licenserolesgroup gp ON m.lower_parent_name = lower(gp.GROUP_ID))
    AND (u.id, u.directory_id) IN (
            SELECT ca.user_id, u.directory_id
            FROM cwd_user_attributes ca
            JOIN cwd_user u ON ca.user_id = u.id
            WHERE attribute_name = 'login.lastLoginMillis' AND to_timestamp(CAST(ca.attribute_value as bigint)/1000) <= current_date - 365
            AND u.directory_id IN (
                SELECT id FROM cwd_directory WHERE active = 1))
    AND (u.id, u.directory_id) NOT IN (
            SELECT ca.user_id, u.directory_id
            FROM cwd_user_attributes ca
            JOIN cwd_user u ON ca.user_id = u.id
            WHERE attribute_name = 'login.lastLoginMillis'
            AND u.directory_id IN (
                SELECT id FROM cwd_directory WHERE active = 0))
ORDER BY 3 DESC; " >> /var/lib/backups/logs/disable_users.txt
cat /var/lib/backups/logs/disable_users.txt| awk '{print $5,$7}' > /var/lib/backups/logs/`date +%Y%m`_disable_users
rm -rf /var/lib/backups/logs/disable_users.txt
exit 0


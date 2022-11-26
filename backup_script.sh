#!/bin/bash

# declaration of variables
dump_path="/var/lib/postgresql/backups"
name_of_JiraDB="jiradb"
name_of_ConfluenceDB="confluencedb"
name_of_CrowdDB="crowddb"
remove_date=$(date -d '-3 day' '+%Y%m%d')
avail_memory=$(df --output=avail -k $dump_path | sed '1d;s/[^0-9]//g')
size_of_db=$(psql --username postgres -A -c "select pg_database_size('$name_of_JiraDB')/1024 as memory" | sed -n 2p)
let "size_of_db *= 3"

if [ $avail_memory -lt $size_of_db ]; then
         echo "From: SENDER backup_system.com " > $dump_path/temp
         echo "To: USER lonshakovaleksei@gmail.com" >> $dump_path/temp
     echo "Subject: Less available space than we need" >> $dump_path/temp
     echo "Create backup failed. Please increase the amount of space." >> $dump_path/temp
         cat $dump_path/temp | sendmail lonshakovaleksei@gmail.com
         exit 1
fi

mv $dump_path"/initial/"* $dump_path/buffer/

pg_dump --username postgres -f /var/lib/postgresql/backups/initial/`date +%Y%m%d_`$name_of_JiraDB.sql $name_of_JiraDB
pg_dump --username postgres -f /var/lib/postgresql/backups/initial/`date +%Y%m%d_`$name_of_ConfluenceDB.sql $name_of_ConfluenceDB
pg_dump --username postgres -f /var/lib/postgresql/backups/initial/`date +%Y%m%d_`$name_of_CrowdDB.sql $name_of_CrowdDB

if [ -e $dump_path/buffer/"$remove_date"_$name_of_JiraDB.sql ] ; then
sudo rm $dump_path/buffer/"$remove_date"_$name_of_JiraDB.sql
fi;

if [ -e $dump_path/buffer/"$remove_date"_$name_of_ConfluenceDB.sql ] ; then
sudo rm $dump_path/buffer/"$remove_date"_$name_of_ConfluenceDB.sql
fi;

if [ -e $dump_path/buffer/"$remove_date"_$name_of_CrowdDB.sql ] ; then
sudo rm $dump_path/buffer/"$remove_date"_$name_of_CrowdDB.sql
fi;
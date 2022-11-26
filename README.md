Databases for Atlassian applications with automatic daily backups
===========================

### Description

This repository contains a Dockerfile for building a Postgresql DBMS image with three databases and their automatic backup, which will be initialized using the following scripts:
 
1. _create_user.sh_ script creates new users in the Postgresql DBMS for Jira, Confluence and Crowd databases
2. _create_db.sh_ script creates new databases in the Postgresql DBMS for Jira, Confluence and Crowd applications
3. _backup_scripr.sh_ script performs regular backups of apps' databases using the pgdump utility. This script will be executed daily at 2 o'clock system time by the cron job scheduler

#### Tables of variables

Database name | User | Application
------------ | ------------- | -------------
DB_NAME1="jiradb" | DB_USER1="jira" | Jira
DB_NAME2="confluencedb" | DB_USER2="confluence" | Confluence
DB_NAME3="crowddb" | DB_USER3="crowd" | Crowd
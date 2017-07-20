#!/bin/sh
# please set following configuration according to your setup
# make sure to have postgres installed on the host your running this script
# script was created for Taskforce Managed Environment- Iteration 1- configuration Management with CMDBUild
password=cmdbuild
user=cmdbuild
host=127.0.0.1
datbase=cmdbuild
sqlscript=initialize_db.sql

export PGPASSWORD=$password; psql $user -h $host -d $database -a -f $sqlscript

#!/bin/bash

set -eo pipefail

function _gen_mariadb_ini() {
  ini_file="$(pwd)/mariadb.ini"

  if [ -f $ini_file ]; then
    echo "Cleaning up previously generated mariadb.ini file"
    rm -f $ini_file
  fi;

  echo "Generating $ini_file"
  touch $ini_file

  if [ ! -f $ini_file ]; then
    echo "Could not create file $ini_file"
    exit 1;
  fi;

  local host=$TS3_DB_HOST
  local port=${TS3_DB_PORT:-3306}
  local user=$TS3_DB_USER
  local pass=$TS3_DB_PASS
  local db=${TS3_DB_NAME:-"ts3"}

  echo "[config]" >> $ini_file
  echo "host=$host" >> $ini_file
  echo "port=$port" >> $ini_file
  echo "username=$user" >> $ini_file
  echo "password=$pass" >> $ini_file
  echo "database=$db" >> $ini_file
}

args=
if [ -n "$TS3_DB_HOST" ]; then
  if [ -z "$TS3_DB_USER" ]; then
    echo "When TS3_DB_HOST is specified TS3_DB_USER must be specified as well"
    exit 1;
  fi;

  echo "Using MariaDB as storage backend"
  _gen_mariadb_ini

  args+='dbplugin=ts3db_mariadb '
  args+='dbsqlcreatepath=create_mariadb/ '
  args+="dbpluginparameter=$ini_file"

  echo "Copying libmariadb.so.2"
  cp redist/libmariadb.so.2 libmariadb.so.2
else
  echo "Using default configuration"
fi;

sh ./ts3server_minimal_runscript.sh $args

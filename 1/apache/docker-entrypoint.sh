#!/bin/bash
set -e

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
  if [ -n "$MYSQL_PORT_3306_TCP" ]; then
    if [ -z "$BACKDROP_DB_HOST" ]; then
      BACKDROP_DB_HOST='mysql'
    else
      echo >&2 'warning: both BACKDROP_DB_HOST and MYSQL_PORT_3306_TCP found'
      echo >&2 "  Connecting to BACKDROP_DB_HOST ($BACKDROP_DB_HOST)"
      echo >&2 '  instead of the linked mysql container'
    fi
  fi

  if [ -z "$BACKDROP_DB_HOST" ]; then
    echo >&2 'error: missing BACKDROP_DB_HOST and MYSQL_PORT_3306_ADDR environment variables'
    echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
    echo >&2 '  with -e BACKDROP_DB_HOST=hostname?'
    exit 1
  fi

  # if we're linked to MySQL and thus have credentials already, let's use them
  : ${BACKDROP_DB_USER:=${MYSQL_ENV_MYSQL_USER:-root}}
  if [ "$BACKDROP_DB_USER" = 'root' ]; then
    : ${BACKDROP_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
  fi

  : ${BACKDROP_DB_PASSWORD:=$MYSQL_ENV_MYSQL_PASSWORD}
  : ${BACKDROP_DB_NAME:=${MYSQL_ENV_MYSQL_DATABASE:-backdrop}}
  : ${BACKDROP_DB_PORT:=${MYSQL_ENV_MYSQL_PORT:-3306}}
  : ${BACKDROP_DB_DRIVER:=${MYSQL_ENV_MYSQL_DRIVER:-mysql}}

  if [ -z "$BACKDROP_DB_PASSWORD" ]; then
    echo >&2 'error: missing required BACKDROP_DB_PASSWORD environment variable'
    echo >&2 '  Did you forget to -e BACKDROP_DB_PASSWORD=... ?'
    echo >&2
    echo >&2 '  (Also of interest might be BACKDROP_DB_USER and BACKDROP_DB_NAME.)'
    exit 1
  fi

  # lets construct our BACKDROP_SETTINGS and pass them into apache or fpm
  export BACKDROP_SETTINGS="{\"databases\":{\"default\":{\"default\":{\"host\":\"database\",\"port\":$BACKDROP_DB_PORT,\"username\":\"$BACKDROP_DB_USER\",\"password\":\"$BACKDROP_DB_PASSWORD\",\"database\":\"$BACKDROP_DB_NAME\",\"driver\":\"$BACKDROP_DB_DRIVER\"}}}}"
  if [[ "$1" == apache2* ]]; then
    echo "PassEnv BACKDROP_SETTINGS" > /etc/apache2/conf-enabled/backdrop.conf
  elif [[ "$1" == php-fpm* ]]; then
    POOL_ENV_LINE="env['BACKDROP_SETTINGS'] = $BACKDROP_SETTINGS"
    POOL_FILE=/usr/local/etc/php-fpm.d/www.conf
    grep -q "$POOL_ENV_LINE" "$POOL_FILE" || echo "$POOL_ENV_LINE" >> "$POOL_FILE"
  fi

fi

exec "$@"

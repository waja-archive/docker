#!/bin/sh

PATH=/home/deploy/realms-wiki/.venv/bin:/usr/local/bin:/usr/bin:/bin:$PATH
export PATH

LC_ALL=en_US.UTF-8
GEVENT_RESOLVER=ares

export LC_ALL
export GEVENT_RESOLVER

if [ "${REALMS_WIKI_CONFIG}" != "" ]; then
    realms-wiki configure "${REALMS_WIKI_CONFIG}"
fi

if [ "${REALMS_WIKI_WORKERS}" == "" ]; then
    REALMS_WIKI_WORKERS=3
fi

if [ "${REALMS_WIKI_PORT}" == "" ]; then
    REALMS_WIKI_PORT=5000
fi

exec chown -R deploy.deploy /home/deploy/realms-wiki

exec gunicorn \
  --name realms-wiki \
  --access-logfile - \
  --error-logfile - \
  --worker-class gevent \
  --workers ${REALMS_WIKI_WORKERS} \
  --bind 0.0.0.0:${REALMS_WIKI_PORT} \
  --user deploy \
  --group deploy \
  --chdir /home/deploy/realms-wiki \
  'realms:create_app()' >>/var/log/realms-wiki/realms-wiki.log 2>&1

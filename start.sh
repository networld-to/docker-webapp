#!/bin/bash
if [ -f /webapp/init.sh ]; then
  . /webapp/init.sh
fi

/opt/nginx/sbin/nginx -c /opt/nginx/conf/nginx.conf

#!/bin/bash

if [ ! -d "/data/conf" ]; then
	CONF_FILE=/data/conf/app.ini
	mkdir -p /data/data /data/log /data/git
        cp -r /go/src/github.com/gogits/gogs/conf/ /data/

	sed -i 's/^ROOT_PATH =/ROOT_PATH = \/data\/log/g' $CONF_FILE

	if [ -n "$SELFSIGNED_CERT_HOST" ]; then
		mkdir -p /data/https
		cd /data/https
		/go/src/github.com/gogits/gogs/gogs cert --ca=true --duration=8760h0m0s --host=$SELFSIGNED_CERT_HOST
		cd /data
		sed -i 's/^PROTOCOL = http/PROTOCOL = https/g' $CONF_FILE
		sed -i 's/^CERT_FILE = custom\/https\/cert.pem/CERT_FILE = \/data\/https\/cert.pem/g' $CONF_FILE
		sed -i 's/^KEY_FILE = custom\/https\/key.pem/KEY_FILE = \/data\/https\/key.pem/g' $CONF_FILE
		sed -i "s/^DOMAIN = localhost/DOMAIN = $SELFSIGNED_CERT_HOST/g" $CONF_FILE

	fi

	chown -R git:git /data
fi

exec su git -c "/go/src/github.com/gogits/gogs/gogs web"

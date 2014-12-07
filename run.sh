#!/bin/bash

if [ ! -d "/data/conf" ]; then	
	mkdir -p /data/data /data/log /data/git
        cp -r /go/src/github.com/gogits/gogs/conf/ /data/

	sed -i 's/^ROOT_PATH =/ROOT_PATH = \/data\/log/g' /data/conf/app.ini

	chown -R git:git /data
fi

exec su git -c "/go/src/github.com/gogits/gogs/gogs web"

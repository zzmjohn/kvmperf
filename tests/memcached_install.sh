#!/bin/bash

dpkg --get-selections | grep '\<memcached\>' > /dev/null 2>&1
if [[ ! $? == 0 ]]; then
	apt-get install -y memcached
	update-rc.d memcached disable
fi

which memslap > /dev/null 2>&1
if [[ ! $? == 0 ]]; then
	apt-get install -y g++

	MEMCACHED=libmemcached-1.0.15
	cd /tmp/
	tar xvzf $MEMCACHED.tar.gz

	pushd $MEMCACHED
	./configure
	make
	make install
	popd
fi


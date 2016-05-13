#!/bin/sh

# update the base system
apk update && apk upgrade

# we need the real (GNU) wget, the one incl. with Alpine's busybox is lacking some options
# install python for 
apk add wget
apk add rsync

# add a non-root user and group called "rsync" with no password, no home dir, no shell, and gid/uid set to 1000
addgroup -g 1000 rsync && adduser -H -D -G rsync -s /bin/false -u 1000 rsync

# create the rsync dir and volume mount points
mkdir /rsync

# check if config exists in /config. If it doesn't, copy the default on from the install dir.
if [ ! -f /config/rsyncd.conf ]; then
  echo "No config found, copying the default config now."
  cp -v /etc/rsyncd.conf /config/rsyncd.conf
fi

# we don't need GNU wget anymore (busybox' wget will still be available).
#apk del wget

# also, clear the apk cache:
#rm -rf /var/cache/apk/*

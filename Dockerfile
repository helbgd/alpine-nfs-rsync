FROM alpine:latest
MAINTAINER Helmuth Angerer <helmut.angerer@googlemail.com>
LABEL Description="alpine with rsync server" Version="0.1"

# copy init files
RUN mkdir /setup 
COPY setup.sh /setup/

# make the escripts executable and run the setup
RUN chmod -v +x /setup/setup.sh && sh /setup/setup.sh

# delete all the setup files
RUN rm -r /setup/

# volume mappings
VOLUME /rsync /config

# exposes nzbget's default port
EXPOSE 873

# not root anymore going forward
USER root

# set some defaults and start nzbget in server and log mode
ENTRYPOINT ["/usr/bin/rsyncd", "--daemon",  "--config=", "/config/rsync.conf "]

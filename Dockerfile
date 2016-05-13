FROM alpine:latest
MAINTAINER Helmuth Angerer <helmut.angerer@googlemail.com>
LABEL Description="alpine with nfs and rsync server" Version="0.1"

# copy init files
RUN mkdir /setup
COPY setup/* /setup/

# make the escripts executable and run the setup
RUN chmod -v +x /setup/*.sh && sh /setup/setup.sh

# delete all the setup files
RUN rm -r /setup/

# volume mappings
VOLUME /export

# exposes nzbget's default port
EXPOSE 

# not root anymore going forward
USER nfs

# set some defaults and start nzbget in server and log mode
ENTRYPOINT ["/nfsd", "-s", "-o", "OutputMode=log", "-c", " "]

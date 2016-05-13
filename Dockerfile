FROM hachque/phabricator:latest
ENV REFRESHED_AT 2016_05_13

VOLUME /srv/files
VOLUME /srv/repo

ADD myScript.sh /myScript.sh
RUN /myScript.sh

WORKDIR /
CMD ["/init"]

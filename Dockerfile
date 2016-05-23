FROM hachque/phabricator:latest
ENV REFRESHED_AT 2016_05_23

ADD addSprintPlugin.sh /addSprintPlugin.sh
RUN /addSprintPlugin.sh

WORKDIR /
CMD ["/init"]

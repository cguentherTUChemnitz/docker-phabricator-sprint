FROM alrouen/docker-phabricator:1.0
ENV REFRESHED_AT 2016_04_18

# Install Sprint extension
RUN git clone https://github.com/wikimedia/phabricator-extensions-Sprint.git /srv/phabricator/phabricator-extensions-Sprint

WORKDIR /srv/phabricator/phabricator/bin
RUN ./config set maniphest.points '{"enabled" : true}'
RUN ./config set load-libraries '{"sprint":"/srv/phabricator/phabricator-extensions-Sprint/src"}'

#disable mysql storage engine for file storage
RUN ./config set storage.mysql-engine.max-size 0

#save files in /srv/files using local file storage engine
RUN mkdir -p /srv/files
#use uid and gid for git:wwwgrp-phabricator
RUN chown 2000:2000 /srv/files
RUN ./config set storage.local-disk.path /srv/files

#create volume and configure local repository path
RUN mkdir -p /srv/repo
RUN chown 2000:2000 /srv/repo
RUN ./config set repository.default-local-path /srv/repo

VOLUME /srv/files
VOLUME /srv/repo

# enforce HTTPS detection (for installation behind reverse proxy that adds/removes HTTPS)
WORKDIR /srv/phabricator/phabricator/support
RUN echo "<?php\n$_SERVER['https']=true;" > preamble.php
RUN chmod a+rx preamble.php

WORKDIR /
CMD ["/init"]

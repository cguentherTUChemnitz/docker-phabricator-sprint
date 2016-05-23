#!/bin/bash

set -e
set -x

# Install Sprint extension
git clone https://github.com/wikimedia/phabricator-extensions-Sprint.git /srv/phabricator/phabricator-extensions-Sprint

# enable sprint extension
cd /srv/phabricator/phabricator/bin
./config set maniphest.points '{"enabled" : true}'
./config set load-libraries '{"sprint":"/srv/phabricator/phabricator-extensions-Sprint/src"}'

# enforce HTTPS detection (for installation behind reverse proxy that adds/removes HTTPS)
cd /srv/phabricator/phabricator/support
echo "<?php" > preamble.php
echo "\$_SERVER['https']=true;" >> preamble.php
chmod a+rx preamble.php

cd /

#!/bin/bash

set -e
set -x

# Install Sprint extension
su git -c 'git clone https://github.com/wikimedia/phabricator-extensions-Sprint.git /srv/phabricator/phabricator-extensions-Sprint'

# enable sprint extension
cd /srv/phabricator/phabricator/bin
./config set maniphest.points '{"enabled" : true}'
./config set load-libraries '{"sprint":"/srv/phabricator/phabricator-extensions-Sprint/src"}'

cd /

#!/usr/bin/env bash

# Syncs the website to the server located at WEBSITE.
#
# This script expects the WEBSITE environmental variable to be set.  If
# not set in ~/.*profile you could launch this script with like this:
#
#   WEBSITE=example.com ./sync.sh
#
# The nginx server configuration should look for /var/www/website
# directory and the directory should be owned by the user 'finn'-- the
# same user as the current local user.

_this=$(readlink -f ${BASH_SOURCE[0]})
_dir=${_this%/*}
_webroot=$(readlink -f ~/web)
_public=${_webroot}/public

time {

# If folder exist; remove it
[[ ! -e ${_public} ]] && rm -rf ${_public}

# Generate public folder
cd ${_webroot}
hugo

# Upload to server
rsync -zrvP --delete-after ${_public} ${WEBSITE}:/var/www/website

}

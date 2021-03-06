#!/bin/sh

/usr/sbin/env-update
. /etc/profile

SYSTEMD_DROP_SERVICES="
	installer-gui
	installer-text
	sabayonlive
	x-setup
"

for serv in ${SYSTEMD_DROP_SERVICES}; do
	systemctl --no-reload -f disable "${serv}.service"
done

# Generate list of installed packages
equo query list installed -qv > /etc/sabayon-pkglist

# remove hw hash
rm -f /etc/entropy/.hw.hash
# remove entropy pid file
rm -f /run/entropy/entropy.lock

# remove /run/* and /var/lock/*
# systemd mounts them using tmpfs
rm -rf /run/*
rm -rf /var/lock/*

exit 0

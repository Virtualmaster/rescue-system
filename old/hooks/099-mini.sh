#!/bin/sh

# /usr/share/live-helper/hooks/mini - hook list for live-helper(7)
# Copyright (C) 2006-2007 Daniel Baumann <daniel@debian.org>
#
# live-helper comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
# This is free software, and you are welcome to redistribute it
# under certain conditions; see COPYING for details.

set -e

exit 0

# Removing unused packages
for PACKAGE in man-db manpages info
do
	if ! apt-get remove --purge --yes "${PACKAGE}"
	then
		echo "WARNING: ${PACKAGE} isn't installed"
	fi
done

apt-get autoremove --yes || true

# Removing unused files
find . -name *~ | xargs rm -f

rm -rf /usr/include/*
#rm -rf /usr/share/groff/*
rm -rf /usr/share/doc/*
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /usr/share/i18n/*
rm -rf /usr/share/info/*
rm -rf /usr/share/zoneinfo/*
rm -rf /var/cache/man/*

# Cleaning apt lists
rm -rf /var/lib/apt/lists
mkdir -p /var/lib/apt/lists/partial

# Cleaning apt cache
rm -rf /var/cache/apt
mkdir -p /var/cache/apt/archives/partial

# Truncating logs
for FILE in $(find /var/log/ -type f)
do
	: > ${FILE}
done

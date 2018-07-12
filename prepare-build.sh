#!/bin/sh

DIST=$1

cp -a tcltls-1.7.16 package-$DIST
cd package-$DIST

# nb: we force the full version number here to get the correct build number (+2) to reflect the earlier, released,
# backport we did for FF 7.8.10

BASE=$(dpkg-parsechangelog -S Version)
BUILD=2

case "$DIST" in
    jessie)
        sed -i -e 's/debhelper (>= 10)/debhelper (>= 9)/' debian/control
        dch --newversion ${BASE}~bpo8+${BUILD} --force-bad-version --distribution jessie-backports --force-distribution "Backport to jessie"
        ;;
    stretch)
        dch --newversion ${BASE}~bpo9+${BUILD} --force-bad-version --distribution stretch-backports --force-distribution "Backport to stretch"
        ;;
    *)
        echo "Don't know how to build tcltls for a distribution named $DIST" >&2
        exit 1
        ;;
esac

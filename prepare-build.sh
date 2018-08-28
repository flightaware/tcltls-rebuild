#!/bin/sh

export DEBFULLNAME=${DEBFULLNAME:-FlightAware build automation}
export DEBEMAIL=${DEBEMAIL:-adsb-devs@flightaware.com}

TOP=$(dirname $0)
DIST=$1
OUT=$2

if [ -n "$OUT" ]
then
    OUT=$(realpath $OUT)
else
    OUT=$(realpath package-$DIST)
fi

cp -a $TOP/tcltls-1.7.16 $OUT
cd $OUT

# nb: we force the full version number here to get the correct build number

BASE=$(dpkg-parsechangelog -S Version)
BUILD=3

case "$DIST" in
    jessie)
        sed -i -e 's/debhelper (>= 10)/debhelper (>= 9)/' debian/control
        dch --newversion ${BASE}~bpo8+${BUILD} --force-bad-version --distribution jessie-backports --force-distribution "Automated backport to jessie"
        ;;
    stretch)
        dch --newversion ${BASE}~bpo9+${BUILD} --force-bad-version --distribution stretch-backports --force-distribution "Automated backport to stretch"
        ;;
    *)
        echo "Don't know how to build tcltls for a distribution named $DIST" >&2
        exit 1
        ;;
esac

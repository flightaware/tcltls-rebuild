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

case "$DIST" in
    jessie)
        sed -i -e 's/debhelper (>= 10)/debhelper (>= 9)/' debian/control
        dch --local ~bpo8+ --distribution jessie-backports --force-distribution "Automated backport to jessie"
        ;;
    stretch)
        dch --local ~bpo9+ --distribution stretch-backports --force-distribution "Automated backport to stretch"
        ;;
    buster)
        ;;
    *)
        echo "Don't know how to build tcltls for a distribution named $DIST" >&2
        exit 1
        ;;
esac

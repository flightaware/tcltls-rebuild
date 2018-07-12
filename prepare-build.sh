#!/bin/sh

# TODO: Handle tcltls versioning number and cd into correct directory

DIST=$1

case "$DIST" in
    wheezy)
        dch --local ~bpo7+ --distribution wheezy-backports --force-distribution "Backport to wheezy"
        ;;
    jessie)
        dch --local ~bpo8+ --distribution jessie-backports --force-distribution "Backport to jessie"
        ;;
    stretch)
        ;;
    *)
        echo "Don't know how to build tcltls for a distribution named $DIST" >&2
        exit 1
        ;;
esac
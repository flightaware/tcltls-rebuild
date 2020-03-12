# tcltls FlightAware rebuild

This is a rebuild of the upstream Debian/Raspbian tcl-tls package,
building with `--enable-ssl-fastpath` to work around an upstream
bug that affects PiAware.

The upstream bug is reported here:
https://core.tcl-lang.org/tcltls/tktview?name=6dd5588df6

This repository also includes infrastructure for backport builds
for stretch / jessie

The package is otherwise the same as the Debian buster 1.7.16-1 package.

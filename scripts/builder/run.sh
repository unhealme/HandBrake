#!/usr/bin/bash
BASEDIR="$(dirname -- "$(readlink -f -- "$0")")" || exit $?
IMAGE='ghcr.io/unhealme/handbrake-builds/builder:latest'

[[ -n "$(docker images -q "$IMAGE")" ]] || docker build -t ghcr.io/unhealme/handbrake-builds/builder:latest "$BASEDIR"
docker run --rm -u 1000:1000 -v "$BASEDIR"/../..:/HandBrake/src:shared --mount type=bind,src="$BASEDIR"/build_win64.sh,dst=/build.sh,ro "$IMAGE" bash /build.sh

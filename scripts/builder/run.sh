#!/usr/bin/bash
BASEDIR="$(dirname -- "$(readlink -f -- "$0")")" || exit $?
IMAGE='ghcr.io/unhealme/handbrake-builds/builder:latest'

CREATED="$(docker inspect --format '{{.Created}}' "$IMAGE")"
if [[ "$(stat -c '%Y' -- "$BASEDIR"/Dockerfile)" -gt "$(date -d "$CREATED" '+%s')" ]]; then
    [[ -n "$CREATED" ]] && docker rmi "$IMAGE"
    docker build -t "$IMAGE" "$BASEDIR" || exit 1
fi
docker run --rm -u 1000:1000 -v "$BASEDIR"/../..:/HandBrake/src:shared --mount type=bind,src="$BASEDIR"/build_win64.sh,dst=/build.sh,ro "$IMAGE" bash /build.sh

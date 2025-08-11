#!/usr/bin/bash
BASEDIR="$(dirname -- "$(readlink -f -- "$0")")" || exit $?
GITDIR="$(realpath -se -- "$BASEDIR"/../..)" || exit $?
IMAGE='ghcr.io/unhealme/handbrake-builds/builder:latest'

CREATED="$(docker inspect --format '{{.Created}}' "$IMAGE")"
if [[ "$(git -C "$GITDIR" log -1 --pretty="format:%ct" -- "$BASEDIR"/Dockerfile)" -gt "$(date -d "$CREATED" '+%s')" ]]; then
    [[ -n "$CREATED" ]] && docker rmi "$IMAGE"
    docker build -t "$IMAGE" "$BASEDIR" || exit 1
fi
docker run --rm -u 1000:1000 -v "$GITDIR":/HandBrake:shared --mount type=bind,src="$BASEDIR"/build_win64.sh,dst=/build.sh,ro "$IMAGE" bash /build.sh

#!/usr/bin/bash

cd /HandBrake/src || exit 1
scripts/mingw-w64-build x86_64 "${HOME}/handbrake/toolchains/"
PATH="${HOME}/handbrake/toolchains/mingw-w64-x86_64/bin:${PATH}" ./configure --enable-fdk-aac --enable-libdovi --enable-nvdec --cross=x86_64-w64-mingw32 --launch-jobs="$(nproc)" --launch

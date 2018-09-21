#!/bin/bash

ARCH=$1
REPO=$2
EXPORT_ARGS=$3
FB_ARGS=$4
SUBJECT=${5:-"org.freedesktop.Sdk.Base `git rev-parse HEAD`"}

echo installing org.flatpak.Builder
flatpak --user install -y flathub org.flatpak.Builder

echo Building SdkBase
flatpak run --command=make org.flatpak.Builder all ARCH="${ARCH}" REPO="${REPO}"
build_exit_code=$?

# Remove builds, they are kind of large, and we rebuild this seldom
echo Removing builds
rm -rf images build

exit "$build_exit_code"

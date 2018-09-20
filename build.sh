#!/bin/bash

ARCH=$1
REPO=$2
EXPORT_ARGS=$3
FB_ARGS=$4
SUBJECT=${5:-"org.freedesktop.Sdk.Base `git rev-parse HEAD`"}

flatpak --user install -y flathub org.flatpak.Builder
flatpak run --command=make org.flatpak.Builder all ARCH="${ARCH}" REPO="${REPO}"

# Remove builds, they are kind of large, and we rebuild this seldom
rm -rf images build

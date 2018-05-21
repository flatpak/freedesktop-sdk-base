#!/bin/bash

ARCH=$1
REPO=$2
EXPORT_ARGS=$3
FB_ARGS=$4
SUBJECT=${5:-"org.freedesktop.Sdk `git rev-parse HEAD`"}

flatpak run --command=make org.flatpak.Builder all ARCH="${ARCH}" REPO="${REPO}"

#
# Copyright (C) 2011 Colin Walters <walters@verbum.org>
#
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit freedesktop-contents

IMAGE_FEATURES += "package-management"

PACKAGE_INSTALL += "\
		task-freedesktop-contents-platform \
		task-freedesktop-contents-sdk \
		libltdl-dev \
		libgcc-dev \
		glibc-dev \
		glibc-dbg \
		linux-libc-headers-dev \
		"

DEPENDS += "task-freedesktop-contents-platform task-freedesktop-contents-sdk "

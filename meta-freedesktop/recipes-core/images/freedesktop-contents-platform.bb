#
# Copyright (C) 2011 Colin Walters <walters@verbum.org>
#
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit freedesktop-contents

ROOTFS_PKGMANAGE = "rpm"

PACKAGE_INSTALL += "\
		task-freedesktop-contents-platform \
		"

DEPENDS += " task-freedesktop-contents-platform "

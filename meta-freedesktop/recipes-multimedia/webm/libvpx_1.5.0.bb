SUMMARY = "VPX multi-format codec"
DESCRIPTION = "The BSD-licensed libvpx reference implementation provides en- and decoders for VP8 and VP9 bitstreams."
HOMEPAGE = "http://www.webmproject.org/code/"
BUGTRACKER = "http://code.google.com/p/webm/issues/list"
SECTION = "libs/multimedia"
LICENSE = "BSD"

LIC_FILES_CHKSUM = "file://LICENSE;md5=d5b04755015be901744a78cc30d390d4"

SRC_URI += "http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-${PV}.tar.bz2"
SRC_URI[md5sum] = "49e59dd184caa255886683facea56fca"
SRC_URI[sha256sum] = "306d67908625675f8e188d37a81fbfafdf5068b09d9aa52702b6fbe601c76797"

DEPENDS = "yasm-native"

CFLAGS += "-fPIC"

export CC
export LD = "${CC}"

VPXTARGET_armv5te = "armv5te-linux-gcc"
VPXTARGET_armv6 = "armv6-linux-gcc"
VPXTARGET_armv7a = "armv7-linux-gcc"
VPXTARGET_x86-64 = "x86_64-linux-gcc"
VPXTARGET_x86 = "x86-linux-gcc"
VPXTARGET_aarch64 = "armv8-linux-gcc"
VPXTARGET ?= "generic-gnu"

CONFIGUREOPTS = " \
    --target=${VPXTARGET} \
    --enable-vp8 \
    --enable-vp9 \
    --enable-libs \
    --disable-install-docs \
    --disable-static \
    --enable-shared \
    --prefix=${prefix} \
    --libdir=${libdir} \
"

CONFIGUREOPTS_append_x86-64 =" --as=yasm"
CONFIGUREOPTS_append_x86 =" --as=yasm"

do_configure() {
    ${S}/configure ${CONFIGUREOPTS}
}

do_compile() {
    oe_runmake
}

do_install() {
    oe_runmake install DESTDIR=${D}
}


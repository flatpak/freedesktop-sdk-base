LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=bc8917ab981cfa6161dc29319a4038d9"

SRC_URI = "https://people.freedesktop.org/~alexl/libverto-0.2.6.tar.gz"
# Original URI, which didn't seem to load for me: https://fedorahosted.org/releases/l/i/libverto/libverto-0.2.6.tar.gz
SRC_URI[md5sum] = "d4e81c21403031089d71eaab07708b89"
SRC_URI[sha256sum] = "17eca6a3855f4884e2e7095e91501767d834b3bf313a6f59a93303f54ac91c9e"

S = "${WORKDIR}/libverto-0.2.6"

inherit pkgconfig autotools

# Don't build glib backend, because we don't want to pull in the yocto glib
EXTRA_OECONF = "--with-pthread --without-glib --without-libev --without-libevent"

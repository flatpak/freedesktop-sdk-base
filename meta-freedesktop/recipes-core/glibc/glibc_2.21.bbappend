FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "\
        file://glibc-static-tls.patch \
        "

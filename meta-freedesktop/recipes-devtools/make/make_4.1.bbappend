FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://make-handle-ttyname-fail.patch \
        "

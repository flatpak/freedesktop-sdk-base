FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://usercustomize.py \
        file://CVE-2018-1060_CVE-2018-1061.patch \
        "

do_install_append() {
        install -m 0755 ${WORKDIR}/usercustomize.py ${D}${libdir}/python2.7/usercustomize.py
}

EXTRA_OECONF += "--enable-unicode=ucs4"

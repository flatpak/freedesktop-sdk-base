FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://usercustomize.py \
        "
SRC_URI_remove = "file://04-default-is-optimized.patch"

do_install_append() {
        install -m 0755 ${WORKDIR}/usercustomize.py ${D}${libdir}/python3.4/usercustomize.py
}

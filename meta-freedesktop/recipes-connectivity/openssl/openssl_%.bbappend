FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2017-3735.patch \
        file://CVE-2017-3737.patch \
        file://CVE-2017-3738.patch \
        file://CVE-2018-0732.patch \
        file://CVE-2018-0739.patch \
        file://debian/soname.patch \
        "

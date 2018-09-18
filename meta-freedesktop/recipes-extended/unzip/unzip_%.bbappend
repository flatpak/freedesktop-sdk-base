FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2014-9913.patch \
        file://CVE-2016-9844.patch \
        "

FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2014-6585.patch \
        file://CVE-2015-4760.patch \
        file://CVE-2016-0494.patch \
        file://CVE-2016-6293.patch \
        file://CVE-2016-7415.patch \
        file://CVE-2017-7867_CVE-2017-7868.patch \
        file://CVE-2017-14952.patch \
        file://CVE-2017-15422.patch \
        "

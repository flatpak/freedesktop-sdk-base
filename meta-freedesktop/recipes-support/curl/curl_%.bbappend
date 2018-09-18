FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2017-8816.patch \
        file://CVE-2017-8817.patch \
        file://CVE-2018-1000120.patch \
        file://CVE-2018-1000121.patch \
        file://CVE-2018-1000122.patch \
        file://CVE-2018-1000301.patch \
        "

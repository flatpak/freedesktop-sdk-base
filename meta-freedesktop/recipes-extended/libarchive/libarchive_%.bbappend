FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2016-10209.patch \
        file://CVE-2016-10349-CVE-2016-10350.patch \
        file://CVE-2017-5601.patch \
        "

FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2017-7741-CVE-2017-7586-CVE-2017-7585.patch \
        file://CVE-2017-7742.patch \
        file://CVE-2017-8365.patch \
        file://CVE-2017-8363.patch \
        file://CVE-2017-8362.patch \
        "
EXTRA_OECONF = "--enable-external-libs"
DEPENDS="libogg libvorbis flac sqlite3"

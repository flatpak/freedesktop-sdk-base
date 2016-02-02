FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://pkg-config-overrides.patch \
        "
EXTRA_OECONF = "--with-internal-glib"

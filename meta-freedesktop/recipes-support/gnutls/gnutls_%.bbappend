FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2017-5334.patch \
        file://CVE-2017-5335.patch \
        file://CVE-2017-5336.patch \
        file://CVE-2017-5337.patch \
        "
PACKAGECONFIG_append_class-target = " p11-kit libtasn1"
DEPENDS_append_class-target = " p11-kit libtasn1"

EXTRA_OECONF += "--with-default-trust-store-file=/etc/ssl/certs/ca-certificates.crt"

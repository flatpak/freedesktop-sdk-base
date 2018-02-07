PACKAGECONFIG_append_class-target = " p11-kit libtasn1"
DEPENDS_append_class-target = " p11-kit libtasn1"

EXTRA_OECONF += "--with-default-trust-store-file=/etc/ssl/certs/ca-certificates.crt"

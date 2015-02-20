DEPENDS =+ "python"
do_configure_prepend () {
        # Ensure we get the correct site-packages path
        export PYTHON_SITE_PACKAGES="${PYTHON_SITEPACKAGES_DIR}"
}

EXTRA_OECONF = "--with-python=${STAGING_BINDIR}/python --without-debug --without-legacy --with-catalog --without-docbook --with-c14n --without-lzma --with-fexceptions"

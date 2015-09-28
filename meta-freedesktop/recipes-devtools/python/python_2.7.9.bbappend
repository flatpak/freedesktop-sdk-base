FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://usercustomize.py \
        "
py_package_preprocess () {
	# copy back the old Makefile to fix target package
	install -m 0644 Makefile.orig ${PKGD}/${libdir}/python${PYTHON_MAJMIN}/config/Makefile

	# Remove references to buildmachine paths in target Makefile and _sysconfigdata
	sed -i -e 's:--sysroot=${STAGING_DIR_TARGET}::g' -e s:'--with-libtool-sysroot=${STAGING_DIR_TARGET}'::g \
		${PKGD}/${libdir}/python${PYTHON_MAJMIN}/config/Makefile \
		${PKGD}/${libdir}/python${PYTHON_MAJMIN}/_sysconfigdata.py
}

do_install_append() {
        install -m 0755 ${WORKDIR}/usercustomize.py ${D}${libdir}/python2.7/usercustomize.py
}

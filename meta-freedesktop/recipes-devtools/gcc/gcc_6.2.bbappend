EXTRA_OECONF_append_qemuarmv7a = "--with-mode=thumb --with-fpu=vfpv3-d16 --with-arch=armv7-a --with-float=hard"

do_install_append () {
	ln -sf ${TARGET_PREFIX}gcov ${D}${bindir}/gcov
	ln -sf ${TARGET_PREFIX}gcov-tool ${D}${bindir}/gcov-tool
}

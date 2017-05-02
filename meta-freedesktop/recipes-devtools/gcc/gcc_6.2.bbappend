do_install_append () {
	ln -sf ${TARGET_PREFIX}gcov ${D}${bindir}/gcov
	ln -sf ${TARGET_PREFIX}gcov-tool ${D}${bindir}/gcov-tool
}

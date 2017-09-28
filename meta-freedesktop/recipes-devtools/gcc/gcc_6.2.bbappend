EXTRA_OECONF_qemuarmv7a := "${@d.getVar("EXTRA_OECONF", True).replace("--program-prefix=${TARGET_SYS}-", "--program-prefix=arm-linux-gnueabihf-")}"
EXTRA_OECONF_qemuarmv7a += "--with-mode=thumb --with-fpu=vfpv3-d16 --with-arch=armv7-a --with-float=hard"

CONFIGUREOPTS_qemuarmv7a := "${@d.getVar("CONFIGUREOPTS", True).replace("--host=${TARGET_SYS}", "--host=arm-linux-gnueabihf")}"
CONFIGUREOPTS_qemuarmv7a := "${@d.getVar("CONFIGUREOPTS_qemuarmv7a", True).replace("--target=${TARGET_SYS}", "--target=arm-linux-gnueabihf")}"

do_install_append () {
	ln -sf ${TARGET_PREFIX}gcov ${D}${bindir}/gcov
	ln -sf ${TARGET_PREFIX}gcov-tool ${D}${bindir}/gcov-tool
}

do_install_qemuarmv7a := "${@d.getVar("do_install", True).replace("${TARGET_SYS}", "arm-linux-gnueabihf")}"
# Deal with unwind.h reference
do_install_qemuarmv7a := "${@d.getVar("do_install_qemuarmv7a", True).replace("/arm-linux-gnueabihf/gcc/arm-linux-gnueabihf/", "/${TARGET_SYS}/gcc/${TARGET_SYS}/")}"

python () {
    if d.getVar("MACHINE", True) == "qemuarmv7a":
        ts = d.getVar("TARGET_SYS", True)
        for i in d.getVar("PACKAGES", True).split():
            v = d.getVar("FILES_" + i, True)
            if v:
                d.setVar("FILES_" + i, v.replace("/" + ts, "/arm-linux-gnueabihf"))
}

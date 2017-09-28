EXTRA_OECONF_qemuarmv7a := "${@d.getVar("EXTRA_OECONF", True).replace("--program-prefix=${TARGET_SYS}-", "--program-prefix=arm-linux-gnueabihf-")}"

CONFIGUREOPTS_qemuarmv7a := "${@d.getVar("CONFIGUREOPTS", True).replace("--target=${TARGET_SYS}", "--target=arm-linux-gnueabihf")}"
CONFIGUREOPTS_qemuarmv7a := "${@d.getVar("CONFIGUREOPTS_qemuarmv7a", True).replace("--host=${TARGET_SYS}", "--host=arm-linux-gnueabihf")}"

do_install_qemuarmv7a := "${@d.getVar("do_install", True).replace("${TARGET_SYS}", "arm-linux-gnueabihf")}"

FILES_${PN}_append_qemuarmv7a = " \
        ${bindir}/arm-linux-gnueabihf* \
        ${prefix}/arm-linux-gnueabihf/bin/*"

python do_package_prepend() {
    if d.getVar("MACHINE", True) == "qemuarmv7a":
        make_alts = d.getVar("USE_ALTERNATIVES_FOR", True) or ""
        prefix = "arm-linux-gnueabihf"
        bindir = d.getVar("bindir", True)
        for alt in make_alts.split():
            d.setVarFlag('ALTERNATIVE_TARGET', alt, bindir + "/" + prefix + alt)
            d.setVarFlag('ALTERNATIVE_LINK_NAME', alt, bindir + "/" + alt)
        d.setVar("USE_ALTERNATIVES_FOR", "")
}

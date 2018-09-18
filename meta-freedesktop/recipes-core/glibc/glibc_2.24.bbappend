FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

ARM_INSTRUCTION_SET = "thumb"

SRC_URI += "\
        file://CVE-2017-18269.patch \
        file://CVE-2018-6551.patch \
        "

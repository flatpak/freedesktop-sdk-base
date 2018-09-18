FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://CVE-2018-0495.patch \
        "
ARM_INSTRUCTION_SET = "thumb"

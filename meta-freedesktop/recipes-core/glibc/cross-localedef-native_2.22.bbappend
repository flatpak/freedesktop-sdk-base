# Tell autotools that we're working in the localedef directory
#
AUTOTOOLS_SCRIPT_PATH = "${S}/localedef"

# Here we need to skip the parent bbclass and do what the grandparent
# does, invoke the autotools stuff
do_configure () {
        autotools_do_configure
}

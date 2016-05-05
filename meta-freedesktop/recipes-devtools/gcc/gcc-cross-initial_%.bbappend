# For some reason on aarch64 building for aarch64, we need
# to run the two make targets separately otherwise the in-tree
# gcc/xgcc is not ready for configure-target-libgcc
do_compile () {
    oe_runmake all-gcc
    oe_runmake configure-target-libgcc
}

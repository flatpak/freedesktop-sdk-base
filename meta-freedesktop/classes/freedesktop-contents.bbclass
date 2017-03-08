#
# Copyright (C) 2011 Colin Walters <walters@verbum.org>
#
inherit image

PACKAGE_INSTALL += " \
		ldd \
		libltdl \
		libicule \
		"

DEPENDS += "task-freedesktop-contents-platform makedevs-native \
	virtual/fakeroot-native \
	"
do_rootfs[umask] = "022"

IMAGE_FEATURES += "read-only-rootfs"

IMAGE_FSTYPES = "tar.gz"

def freedesktop_get_devtable_list(d):
    return bb.which(d.getVar('BBPATH', 1), 'files/device_table-minimal.txt')

# Must call real_do_rootfs() from inside here, rather than as a separate
# task, so that we have a single fakeroot context for the whole process.
fakeroot prepare_rootfs () {
        set -x
        echo ${DEPLOY_DIR_IMAGE}
        echo ${WORKDIR}
        echo ${IMAGE_ROOTFS}

	# Adjustments for /etc -> {/var,/run} here
	ln -sf /run/resolv.conf ${IMAGE_ROOTFS}/etc/resolv.conf

	# Install defaults
	rm -f ${IMAGE_ROOTFS}/etc/localtime
	ln -s ../usr/share/zoneinfo/Europe/London ${IMAGE_ROOTFS}/etc/localtime
	echo LANG=\"en_US.UTF-8\" > ${IMAGE_ROOTFS}/etc/locale.conf

	# Intersection of defaults between RHEL and Debian
	cat > ${IMAGE_ROOTFS}/etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost6 ip6-localhost
EOF

	# Clear out the default fstab; everything we need right now is mounted
	# in the initramfs.
	cat < /dev/null > ${IMAGE_ROOTFS}/etc/fstab

	# Remove su; it'll never work
	rm -f ${IMAGE_ROOTFS}/bin/su

	# Do UsrMove for bin and sbin
        cd ${IMAGE_ROOTFS}/bin
        for x in *; do
          if test -L ${x} && test -x ../usr/bin/${x}; then
	    rm ${x}
	  else
            mv ${x} ../usr/bin/${x}
          fi
        done
        cd -
	if test -d ${IMAGE_ROOTFS}/bin/.debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/bin/.debug
	  mv ${IMAGE_ROOTFS}/bin/.debug/* ${IMAGE_ROOTFS}/usr/bin/.debug
	  rmdir ${IMAGE_ROOTFS}/bin/.debug
	fi
	rmdir ${IMAGE_ROOTFS}/bin
	ln -s usr/bin ${IMAGE_ROOTFS}/bin
	mv ${IMAGE_ROOTFS}/sbin/* ${IMAGE_ROOTFS}/usr/sbin
	if test -d ${IMAGE_ROOTFS}/sbin/.debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/sbin/.debug
	  mv ${IMAGE_ROOTFS}/sbin/.debug/* ${IMAGE_ROOTFS}/usr/sbin/.debug
	  rmdir ${IMAGE_ROOTFS}/sbin/.debug
	fi
	rmdir ${IMAGE_ROOTFS}/sbin
	ln -s usr/sbin ${IMAGE_ROOTFS}/sbin
	# Now, we need to fix up any symbolic links that were
	# trying to do ../usr/
	for d in ${IMAGE_ROOTFS}/usr/bin ${IMAGE_ROOTFS}/usr/sbin; do
	    find $d -maxdepth 1 -type l | while read f; do
	        target=$(readlink $f)
	        fixed_target=$(echo $target | sed -e 's,^[.][.]/usr,,')
		ln -sf $fixed_target $f
	    done
	done

	# Undo libattr/libacl weirdness
	rm -f ${IMAGE_ROOTFS}/lib/libacl.a
	rm -f ${IMAGE_ROOTFS}/lib/libacl.la
	rm -f ${IMAGE_ROOTFS}/lib/libattr.a
	rm -f ${IMAGE_ROOTFS}/lib/libattr.la
	rm -f ${IMAGE_ROOTFS}/usr/lib/libacl.so
	rm -f ${IMAGE_ROOTFS}/usr/lib/libattr.so

	# Complete UsrMove for lib
	mv ${IMAGE_ROOTFS}/lib/* ${IMAGE_ROOTFS}/usr/lib
	if test -d ${IMAGE_ROOTFS}/lib/.debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/lib/.debug
	  mv ${IMAGE_ROOTFS}/lib/.debug/* ${IMAGE_ROOTFS}/usr/lib/.debug
	  rmdir ${IMAGE_ROOTFS}/lib/.debug
	fi
	rmdir ${IMAGE_ROOTFS}/lib
	ln -s usr/lib ${IMAGE_ROOTFS}/lib

	# And now let's take the next logical step, merge /usr/sbin
	# into /usr/bin.  Rusty Russell will be overjoyed:
	# http://rusty.ozlabs.org/?p=236

	if test -d ${IMAGE_ROOTFS}/usr/sbin/.debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/bin/.debug
	  mv ${IMAGE_ROOTFS}/usr/sbin/.debug/* ${IMAGE_ROOTFS}/usr/bin/.debug
	  rmdir ${IMAGE_ROOTFS}/usr/sbin/.debug
	fi
        cd ${IMAGE_ROOTFS}/usr/sbin
	for x in *; do
          if test -L ${x} && test -x ../bin/${x}; then
	    rm ${x}
	  else
	    mv ${x} ../bin
          fi
	done
        cd -
	rmdir ${IMAGE_ROOTFS}/usr/sbin
	ln -s bin ${IMAGE_ROOTFS}/usr/sbin

	# /lib64/ld-linux-x86-64.so.2 is part of the x86-64 ABI that at least llvm requires
	if [ "${TARGET_ARCH}" = "x86_64" ];then
	  mkdir -p ${IMAGE_ROOTFS}/usr/lib64
	  ln -s ../lib/ld-linux-x86-64.so.2 ${IMAGE_ROOTFS}/usr/lib64/ld-linux-x86-64.so.2
	fi

        # Move debuginfo
        if test -d ${IMAGE_ROOTFS}/usr/bin/.debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/lib/debug/usr/bin
	  mv ${IMAGE_ROOTFS}/usr/bin/.debug/* ${IMAGE_ROOTFS}/usr/lib/debug/usr/bin
	  rmdir ${IMAGE_ROOTFS}/usr/bin/.debug
	fi
        if test -d ${IMAGE_ROOTFS}/usr/lib/.debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/lib/debug/usr/lib
	  mv ${IMAGE_ROOTFS}/usr/lib/.debug/* ${IMAGE_ROOTFS}/usr/lib/debug/usr/lib
	  rmdir ${IMAGE_ROOTFS}/usr/lib/.debug
	fi
        if test -d ${IMAGE_ROOTFS}/usr/src/debug; then
	  mkdir -p ${IMAGE_ROOTFS}/usr/lib/debug/source
	  mv ${IMAGE_ROOTFS}/usr/src/debug/* ${IMAGE_ROOTFS}/usr/lib/debug/source/
	  rmdir ${IMAGE_ROOTFS}/usr/src/debug
	  ln -s ../lib/debug/source ${IMAGE_ROOTFS}/usr/src/debug
        fi

	# Remove all .la files
	find ${IMAGE_ROOTFS}/usr/lib -name \*.la -delete

	rm -rf ${WORKDIR}/contents
	mkdir -m 0755 ${WORKDIR}/contents
        cd ${WORKDIR}/contents

	# The default toplevel directories used as mount targets
	for d in dev proc run sys var; do
	    mkdir -m 0755 $d
	done

	# /tmp is an empty mountpoint
	mkdir tmp

        # Resolve alternatives of the form "toolname.package => toolname", such as
        # e.g. cat.coreutils -> cat (but not ones of the form busybox -> cat).
        # This makes for cleaner images, and we throw away the alternatives
        # data anyway, so the links are useless.
        for alt in ${IMAGE_ROOTFS}/usr/lib/opkg/alternatives/*; do
            name=`basename $alt`
            link=`head -n 1 $alt`
            prio=`sed -ne "1!p" $alt | sed -e "s/\(.*\) \(.*\)/\2 \1/g" | sort -nr | head -n 1 | sed 's/ [^ ]*$//'`
            path=`grep "${prio}$" $alt | tail -n 1 | sed 's/ [^ ]*$//'`
            path_basename=`basename $path`
            package=`echo $path_basename | sed s/$name.//`
            if [ "$name.$package" = "$path_basename" ] ; then
               if [ -f "${IMAGE_ROOTFS}/$path" ] ; then
                  mv -f "${IMAGE_ROOTFS}/$path" "${IMAGE_ROOTFS}/$link"
               fi
            fi
        done

	# These are the only directories we take from the OE build
        mv ${IMAGE_ROOTFS}/usr .
        mv ${IMAGE_ROOTFS}/etc .
        # Need this for the rpmdb
        mv ${IMAGE_ROOTFS}/var .

	# Also move the toplevel compat links
        mv ${IMAGE_ROOTFS}/lib .
        mv ${IMAGE_ROOTFS}/bin .
        mv ${IMAGE_ROOTFS}/sbin .

	# Ok, let's globally fix permissions in the OE content;
	# everything is root owned, all directories are u=rwx,g=rx,og=rx.
	chown -R -h 0:0 usr
        find usr -type d -exec chmod u=rwx,g=rx,og=rx "{}" \;

	rm -rf ${IMAGE_ROOTFS}
	mv ${WORKDIR}/contents ${IMAGE_ROOTFS}
}

ROOTFS_POSTPROCESS_COMMAND += "prepare_rootfs;"

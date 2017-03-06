#
# Copyright (C) 2011 Colin Walters <walters@verbum.org>
#
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"
ALLOW_EMPTY_${PN} = "1"

PR = "3"

# We explicitly want -dbg packages
INSANE_SKIP_${PN} = "debug-deps dev-deps"

RDEPENDS_${PN} += "     \
         bc \
         chrpath \
         diffutils \
         file \
         patch \
         strace \
         \
         autoconf \
         automake \
         binutils \
         binutils-symlinks \
         bison \
         ccache \
         cmake \
         ninja \
         cpp \
         cpp-symlinks \
         flex \
         g++ \
         g++-symlinks \
         gcc \
         gcc-symlinks \
         glibc-staticdev \
         libstdc++-staticdev \
         gcov \
         gdb \
         gettext \
         gettext-staticdev \
         git \
         git-perltools \
         git-bash-completion \
         gperf \
         intltool \
         ldd \
         libtool \
         libtool-dev \
         make \
         pkgconfig \
         texinfo \
         e2fsprogs-dev \
         libgomp-dev \
         libgomp-staticdev \
         libatomic-dev \
         libatomic-staticdev \
         openssh-ssh \
         openssh-scp \
         openssh-sftp \
         perf \
         sgml-common \
         docbook-xml-dtd4 \
         docbook-xsl-stylesheets \
         \
         libxml-parser-perl \
         libxml-parser-perl-dev \
         perl-modules \
         python-dev \
         python-modules \
         python-misc \
         python3-dev \
         python3-modules \
         python3-misc \
         python-mako \
         python3-pip \
         python-pip \
         ruby \
         \
         gdbm-dev \
         gettext-dev \
         libffi-dev \
         libpam-dev \
         libssp-dev \
         libssp-staticdev \
         util-linux-libuuid-dev \
         util-linux-bash-completion \
         libpcre-dev \
         \
         cracklib-dev \
         curl-dev \
         db-dev \
         icu-dev \
         krb5-dev \
         libverto-dev \
         acl-dev \
         attr-dev \
         attr-staticdev \
         libcap-bin \
         libcap-dev \
         libcap-staticdev \
         libsqlite3-dev \
         libstdc++-dev \
         libstdc++-staticdev \
         ncurses-dev \
         nspr-dev \
         nss-dev \
         \
         libexif-dev \
         libjpeg-turbo-dev \
         libogg-dev \
         libpng-dev \
         libsndfile1-dev \
         libvorbis-dev \
         libvpx-dev \
         libwebp-dev \
         giflib-dev \
         libtheora-dev \
         tiff-dev \
         flac-dev \
         speex-dev \
         libsamplerate0-dev \
         \
         bzip2-dev \
         libarchive-dev \
         xz-dev \
         xz-staticdev \
         zlib-dev \
         zlib-staticdev \
         \
         gnutls-dev \
         libgcrypt-dev \
         libgpg-error-dev \
         libtasn1-bin \
         libtasn1-dev \
         nettle-dev \
         openssl-dev \
         libassuan-dev \
         gpgme-dev \
         \
         cyrus-sasl-dev \
         elfutils-binutils \
         elfutils-dev \
         expat-dev \
         gmp-dev \
         iso-codes-dev \
         json-c-dev \
         lcms-dev \
         libatomic-ops-dev \
         libatomic-ops-staticdev \
         libgcc-dev \
         libxml2-dev \
         libxml2-python \
         libxslt-bin \
         libxslt-dev \
         popt-dev \
         readline-dev \
         \
         perl-dev \
         perl-modules \
	 "

# Some things are only available on x86
RDEPENDS_${PN}_append_x86-64 = " valgrind valgrind-dev libasan-staticdev libubsan-staticdev liblsan-staticdev libtsan-staticdev nasm yasm"
RDEPENDS_${PN}_append_x86 =    " valgrind valgrind-dev libasan-staticdev libubsan-staticdev nasm yasm"

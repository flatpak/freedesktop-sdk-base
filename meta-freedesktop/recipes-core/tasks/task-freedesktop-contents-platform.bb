#
# Copyright (C) 2011 Colin Walters <walters@verbum.org>
#
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"
ALLOW_EMPTY_${PN} = "1"

PR = "1"

RDEPENDS_${PN} += "\
         glibc-gconvs \
         glibc-binaries \
         glibc-charmaps \
         glibc-utils \
         glibc-locale \
         elfutils \
         libffi \
         libssp \
         libstdc++ \
         ncurses \
         nspr \
         gmp \
         mpfr \
         libmpc \
         libgomp \
         libatomic \
         libatomic-ops \
         popt \
         util-linux-libuuid \
         util-linux-libmount \
         libpcre libpcrecpp libpcreposix \
         libcomerr \
         \
         acl \
         attr \
         base-files \
         base-passwd \
         bash \
         coreutils \
         procps \
         cpio \
         cracklib \
         libcurl \
         curl \
         findutils \
         gawk \
         grep \
         krb5 \
         less \
         ncurses-terminfo-base \
         sed \
         update-alternatives-cworth \
         which \
         util-linux-uuidgen \
         util-linux-getopt \
         file \
         \
         bzip2 \
         gzip \
         libarchive \
         liblzma \
         tar \
         unzip \
         xz \
         zip \
         \
         nss \
         p11-kit \
         gnutls \
         libgcrypt \
         libssl \
         libtasn1 \
         gpgme \
         gnupg \
         gpgme-pthread \
         \
         libexif \
         libjpeg-turbo \
         libogg \
         libpng \
         libsndfile1 \
         libvorbis \
         libvpx \
         libwebp \
         giflib \
         libtheora \
         tiff \
         libflac \
         libflac++ \
         speex \
         speexdsp \
         libsamplerate0 \
         \
         icu \
         ca-certificates \
         iso-codes \
         \
         expat \
         json-c \
         libxml2 \
         libxml2-python \
         libxslt \
         \
         cyrus-sasl \
         sqlite3 libsqlite3 \
         gdbm \
         lcms \
         \
         python-modules \
         python-misc \
         python3-modules \
         python3-misc \
         \
         tzdata \
         tzdata-africa \
         tzdata-americas \
         tzdata-antarctica \
         tzdata-arctic \
         tzdata-asia \
         tzdata-atlantic \
         tzdata-australia \
         tzdata-europe \
         tzdata-misc \
         tzdata-pacific \
         tzdata-posix \
         tzdata-right \
         glibc-gconvs \
         glibc-charmaps \
         iso-codes-locale-af \
         iso-codes-locale-am \
         iso-codes-locale-ar \
         iso-codes-locale-as \
         iso-codes-locale-ast \
         iso-codes-locale-az \
         iso-codes-locale-be \
         iso-codes-locale-bg \
         iso-codes-locale-bn \
         iso-codes-locale-bn-in \
         iso-codes-locale-br \
         iso-codes-locale-bs \
         iso-codes-locale-byn \
         iso-codes-locale-ca \
         iso-codes-locale-crh \
         iso-codes-locale-cs \
         iso-codes-locale-cy \
         iso-codes-locale-da \
         iso-codes-locale-de \
         iso-codes-locale-dz \
         iso-codes-locale-el \
         iso-codes-locale-en \
         iso-codes-locale-eo \
         iso-codes-locale-es \
         iso-codes-locale-et \
         iso-codes-locale-eu \
         iso-codes-locale-fa \
         iso-codes-locale-fi \
         iso-codes-locale-fo \
         iso-codes-locale-fr \
         iso-codes-locale-ga \
         iso-codes-locale-gez \
         iso-codes-locale-gl \
         iso-codes-locale-gu \
         iso-codes-locale-haw \
         iso-codes-locale-he \
         iso-codes-locale-hi \
         iso-codes-locale-hr \
         iso-codes-locale-hu \
         iso-codes-locale-hy \
         iso-codes-locale-ia \
         iso-codes-locale-id \
         iso-codes-locale-is \
         iso-codes-locale-it \
         iso-codes-locale-ja \
         iso-codes-locale-ka \
         iso-codes-locale-kk \
         iso-codes-locale-km \
         iso-codes-locale-kn \
         iso-codes-locale-ko \
         iso-codes-locale-kok \
         iso-codes-locale-ku \
         iso-codes-locale-lt \
         iso-codes-locale-lv \
         iso-codes-locale-mi \
         iso-codes-locale-mk \
         iso-codes-locale-ml \
         iso-codes-locale-mn \
         iso-codes-locale-mr \
         iso-codes-locale-ms \
         iso-codes-locale-mt \
         iso-codes-locale-nb \
         iso-codes-locale-ne \
         iso-codes-locale-nl \
         iso-codes-locale-nn \
         iso-codes-locale-nso \
         iso-codes-locale-oc \
         iso-codes-locale-or \
         iso-codes-locale-pa \
         iso-codes-locale-pl \
         iso-codes-locale-ps \
         iso-codes-locale-pt \
         iso-codes-locale-pt-br \
         iso-codes-locale-ro \
         iso-codes-locale-ru \
         iso-codes-locale-rw \
         iso-codes-locale-si \
         iso-codes-locale-sk \
         iso-codes-locale-sl \
         iso-codes-locale-so \
         iso-codes-locale-sq \
         iso-codes-locale-sr \
         iso-codes-locale-sr+latin \
         iso-codes-locale-sv \
         iso-codes-locale-sw \
         iso-codes-locale-ta \
         iso-codes-locale-te \
         iso-codes-locale-th \
         iso-codes-locale-ti \
         iso-codes-locale-tig \
         iso-codes-locale-tk \
         iso-codes-locale-tl \
         iso-codes-locale-tr \
         iso-codes-locale-tt \
         iso-codes-locale-tt+iqtelif \
         iso-codes-locale-ug \
         iso-codes-locale-uk \
         iso-codes-locale-ve \
         iso-codes-locale-vi \
         iso-codes-locale-wa \
         iso-codes-locale-wal \
         iso-codes-locale-wo \
         iso-codes-locale-xh \
         iso-codes-locale-zh-cn \
         iso-codes-locale-zh-hk \
         iso-codes-locale-zh-tw \
         iso-codes-locale-zu \
         "

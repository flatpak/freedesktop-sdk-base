# Override the arch with `make ARCH=i386`
VERSION = 1.6
ARCH   ?= $(shell flatpak --default-arch)
REPO   ?= repo

# Canned recipe for generating metadata
#   $1 = the input file to substitute
#   $2 = the output to create
define subst-metadata
	@echo -n "Generating ${2}... ";		\
	sed -e 's/@@ARCH@@/${ARCH}/g'		\
	    -e 's/@@VERSION@@/${VERSION}/g'	\
	   ${1} > ${2}.tmp && mv ${2}.tmp ${2} || exit 1;
	@echo "Done.";
endef

srcdir = $(CURDIR)
builddir = $(CURDIR)
NULL=
HASH:=$(shell git rev-parse HEAD)
IMAGEDIR=images/${ARCH}
SDK_MANIFEST=${IMAGEDIR}/freedesktop-contents-sdk-${VERSION}-${ARCH}-${HASH}.manifest
PLATFORM_MANIFEST=${IMAGEDIR}/freedesktop-contents-platform-${VERSION}-${ARCH}-${HASH}.manifest
SDK_IMAGE=${IMAGEDIR}/freedesktop-contents-sdk-${VERSION}-${ARCH}-${HASH}.tar.gz
PLATFORM_IMAGE=${IMAGEDIR}/freedesktop-contents-platform-${VERSION}-${ARCH}-${HASH}.tar.gz
IMAGES= ${SDK_IMAGE} ${PLATFORM_IMAGE}
REF_PLATFORM=runtime/org.freedesktop.BasePlatform/${ARCH}/${VERSION}
REF_SDK=runtime/org.freedesktop.BaseSdk/${ARCH}/${VERSION}
FILE_REF_PLATFORM=${REPO}/refs/heads/${REF_PLATFORM}
FILE_REF_SDK=${REPO}/refs/heads/${REF_SDK}

all: ${FILE_REF_PLATFORM} ${FILE_REF_SDK}

COMMIT_ARGS=--repo=${REPO} --canonical-permissions

${IMAGES} allimages:
	rm -f ${IMAGEDIR}/freedesktop-contents-*.tar.gz # Remove all old images to make space
	git submodule update --init
	mkdir -p build/${ARCH}
	./freedesktop-sdk-build-yocto ${srcdir}/ ${builddir}/build/ ${ARCH} ${HASH} ${VERSION}

.PHONY: sdk platform

sdk: ${FILE_REF_SDK}

${FILE_REF_SDK}: metadata.sdk.in ${SDK_IMAGE}
	if [ !  -d ${REPO} ]; then  ostree  init --mode=archive-z2 --repo=${REPO};  fi
	rm -rf sdk
	mkdir sdk
	(cd sdk; tar --transform 's,^./usr,files,S' --transform 's,^./etc,files/etc,S' --exclude="./[!eu]*" -xvf ../${SDK_IMAGE}  > /dev/null)
	cp ${SDK_MANIFEST} sdk/files/manifest.base
	echo "Removing stale python files"
	find sdk -type f -name '*.pyc' -exec sh -c 'test "$$1" -ot "$${1%c}"' -- {} \; -print -delete # Remove stale 2.7 .pyc files
	find sdk -type f -name '*.pyo' -exec sh -c 'test "$$1" -ot "$${1%o}"' -- {} \; -print -delete # Remove stale 2.7 .pyc files
	$(call subst-metadata,metadata.sdk.in,sdk/metadata)
	ostree commit ${COMMIT_ARGS} ${GPG_ARGS} --branch=${REF_SDK}  -s "build of ${HASH}" sdk
	flatpak build-update-repo ${GPG_ARGS} ${REPO}
	rm -rf sdk

platform: ${FILE_REF_PLATFORM}

${FILE_REF_PLATFORM}: metadata.platform.in ${PLATFORM_IMAGE}
	if [ !  -d ${REPO} ]; then  ostree  init --mode=archive-z2 --repo=${REPO};  fi
	rm -rf platform
	mkdir platform
	(cd platform; tar --transform 's,^./usr,files,S' --transform 's,^./etc,files/etc,S' --exclude="./[!eu]*" -xvf ../${PLATFORM_IMAGE}  > /dev/null)
	cp ${PLATFORM_MANIFEST} platform/files/manifest.base
	echo "Removing stale python files"
	find platform -type f -name '*.pyc' -exec sh -c 'test "$$1" -ot "$${1%c}"' -- {} \; -print -delete # Remove stale 2.7 .pyc files
	find platform -type f -name '*.pyo' -exec sh -c 'test "$$1" -ot "$${1%o}"' -- {} \; -print -delete # Remove stale 2.7 .pyc files
	$(call subst-metadata,metadata.platform.in,platform/metadata)
	ostree commit ${COMMIT_ARGS} ${GPG_ARGS} --branch=${REF_PLATFORM}  -s "build of ${HASH}" platform
	flatpak build-update-repo ${GPG_ARGS} ${REPO}
	rm -rf platform

sandboxed:
	flatpak run --command=make org.flatpak.Builder all ARCH="${ARCH}" REPO="${REPO}"

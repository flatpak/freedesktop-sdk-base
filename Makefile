srcdir = $(CURDIR)
builddir = $(CURDIR)

NULL=
ARCH=x86_64
IMAGEDIR=images/$(ARCH)
HASH:=$(shell git rev-parse HEAD)
SDK_IMAGE=$(IMAGEDIR)/freedesktop-contents-sdk-$(ARCH)-$(HASH).tar.gz
PLATFORM_IMAGE=$(IMAGEDIR)/freedesktop-contents-platform-$(ARCH)-$(HASH).tar.gz
IMAGES= $(SDK_IMAGE) $(PLATFORM_IMAGE)
VERSION=1.4

all: $(IMAGES)

COMMIT_ARGS=--generate-sizes --repo=repo --owner-uid=0 --owner-gid=0 --no-xattrs

 $(IMAGES) allimages:
	git submodule update --init
	mkdir -p build/$(ARCH)
	./freedesktop-sdk-build-yocto $(srcdir)/ $(builddir)/build/ $(ARCH) $(HASH)

repo:
	ostree  init --mode=archive-z2 --repo=repo

.PHONY: commit-sdk commit-platform commit

sdk: metadata.sdk $(SDK_IMAGE)
	rm -rf sdk
	mkdir sdk
	(cd sdk; tar --transform 's,^./usr,files,S' --transform 's,^./etc,files/etc,S' --exclude="./[!eu]*" -xvf ../$(SDK_IMAGE)  > /dev/null)
	cp metadata.sdk sdk/metadata

commit-sdk: sdk repo
	ostree commit ${COMMIT_ARGS} ${GPG_ARGS} --branch=runtime/org.freedesktop.BaseSdk/${ARCH}/${VERSION}  -s "build of ${HASH}" sdk
	ostree summary -u --repo=repo

platform: metadata.platform $(PLATFORM_IMAGE)
	rm -rf platform
	mkdir platform
	(cd platform; tar --transform 's,^./usr,files,S' --transform 's,^./etc,files/etc,S' --exclude="./[!eu]*" -xvf ../$(PLATFORM_IMAGE)  > /dev/null)
	cp metadata.platform platform/metadata

commit-platform: platform
	ostree commit ${COMMIT_ARGS} ${GPG_ARGS} --branch=runtime/org.freedesktop.BasePlatform/${ARCH}/${VERSION}  -s "build of ${HASH}" platform
	ostree summary -u --repo=repo

commit: commit-sdk commit-platform

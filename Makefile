srcdir = $(CURDIR)
builddir = $(CURDIR)

NULL=
ARCH=x86_64
IMAGEDIR=images/$(ARCH)
HASH:=$(shell git rev-parse HEAD)
IMAGES=$(IMAGEDIR)/freedesktop-base-contents-sdk-$(ARCH)-$(HASH).tar.gz $(IMAGEDIR)/freedesktop-base-contents-platform-$(ARCH)-$(HASH).tar.gz

all: $(IMAGES)

 $(IMAGES) allimages:
	#git submodule update --init
	mkdir -p build/$(ARCH)
	./freedesktop-sdk-build-yocto $(srcdir)/ $(builddir)/build/ $(ARCH) $(HASH)

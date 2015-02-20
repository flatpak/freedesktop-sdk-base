srcdir = $(CURDIR)
builddir = $(CURDIR)

NULL=
ARCH=x86_64
IMAGES=build/$(ARCH)/images

all: images

$(IMAGES)/freedesktop-base-contents-sdk-$(ARCH).tar.gz $(IMAGES)/freedesktop-base-contents-platform-$(ARCH).tar.gz images:
	(git submodule update --init;)
	mkdir -p build/$(ARCH)
	./freedesktop-sdk-build-yocto ${srcdir}/ ${builddir}/build/ $(ARCH)

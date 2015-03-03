FILES_${PN}-compression="${libdir}/python3.3/gzip.* ${libdir}/python3.3/zipfile.* ${libdir}/python3.3/tarfile.* ${libdir}/python3.3/lib-dynload/_bz2.*.so "
FILES_${PN}-crypt="${libdir}/python3.3/hashlib.* ${libdir}/python3.3/md5.* ${libdir}/python3.3/sha.* ${libdir}/python3.3/lib-dynload/_crypt.*.so ${libdir}/python3.3/lib-dynload/_hashlib.*.so ${libdir}/python3.3/lib-dynload/_sha256.*.so ${libdir}/python3.3/lib-dynload/_sha512.*.so "
FILES_${PN}-datetime="${libdir}/python3.3/_strptime.* ${libdir}/python3.3/calendar.* ${libdir}/python3.3/lib-dynload/_datetime.*.so "
FILES_${PN}-lang="${libdir}/python3.3/lib-dynload/_bisect.*.so ${libdir}/python3.3/lib-dynload/_collections.*.so ${libdir}/python3.3/lib-dynload/_heapq.*.so ${libdir}/python3.3/lib-dynload/_weakref.*.so ${libdir}/python3.3/lib-dynload/_functools.*.so ${libdir}/python3.3/lib-dynload/array.*.so ${libdir}/python3.3/lib-dynload/itertools.*.so ${libdir}/python3.3/lib-dynload/operator.*.so ${libdir}/python3.3/lib-dynload/parser.*.so ${libdir}/python3.3/atexit.* ${libdir}/python3.3/lib-dynload/atexit.*.so ${libdir}/python3.3/bisect.* ${libdir}/python3.3/code.* ${libdir}/python3.3/codeop.* ${libdir}/python3.3/collections.* ${libdir}/python3.3/dis.* ${libdir}/python3.3/functools.* ${libdir}/python3.3/heapq.* ${libdir}/python3.3/inspect.* ${libdir}/python3.3/keyword.* ${libdir}/python3.3/opcode.* ${libdir}/python3.3/symbol.* ${libdir}/python3.3/repr.* ${libdir}/python3.3/token.* ${libdir}/python3.3/tokenize.* ${libdir}/python3.3/traceback.* ${libdir}/python3.3/weakref.* "
FILES_${PN}-numbers="${libdir}/python3.3/decimal.* ${libdir}/python3.3/numbers.* ${libdir}/python3.3/lib-dynload/_decimal.*.so"
FILES_${PN}-pickle="${libdir}/python3.3/pickle.* ${libdir}/python3.3/shelve.* ${libdir}/python3.3/lib-dynload/cPickle.*.so ${libdir}/python3.3/pickletools.* ${libdir}/python3.3/lib-dynload/_pickle.*.so"
FILES_${PN}-subprocess="${libdir}/python3.3/subprocess.* ${libdir}/python3.3/lib-dynload/_posixsubprocess.*.so"

FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "\
        file://999-distutils-fix-unset-env.patch \
        "

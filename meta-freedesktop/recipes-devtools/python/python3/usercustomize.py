from distutils import sysconfig
import sys

sys.path.insert(1, sysconfig.get_python_lib(prefix="/app"))

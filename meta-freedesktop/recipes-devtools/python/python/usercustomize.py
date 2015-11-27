from distutils import sysconfig
import sys
import site

site.addsitedir(sysconfig.get_python_lib(prefix='/app'))

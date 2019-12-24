dnl Autoconf configure script for asfbench

dnl Process this file with autoconf to produce a configure script.

AC_INIT(src/asfbench.ads)

AC_CANONICAL_SYSTEM
dnl AM_MAINTAINER_MODE

# Current release settings
ASFBENCH_MAJOR_VERSION=0
ASFBENCH_MINOR_VERSION=1
ASFBENCH_MICRO_VERSION=0
ASFBENCH_VERSION=$ASFBENCH_MAJOR_VERSION.$ASFBENCH_MINOR_VERSION.$ASFBENCH_MICRO_VERSION

AM_GNAT_LIBRARY_PROJECT(asfbench)

# checking for local tools
AC_PROG_CC
AC_PROG_MAKE_SET
AC_PROG_INSTALL
AC_PROG_LN_S

# Set the version number of the project
AC_SUBST(ASFBENCH_VERSION)
AC_SUBST(ASFBENCH_MAJOR_VERSION)
AC_SUBST(ASFBENCH_MINOR_VERSION)
AC_SUBST(ASFBENCH_MICRO_VERSION)

EXEC_PREFIX="$prefix"
AC_SUBST(EXEC_PREFIX)
ASFBENCH_LIBDIR="lib"
AC_SUBST(ASFBENCH_LIBDIR)

AC_MSG_CHECKING([number of processors])
NR_CPUS=`getconf _NPROCESSORS_CONF 2>/dev/null || getconf NPROCESSORS_CONF 2>/dev/null || echo 1`
AC_MSG_RESULT($NR_CPUS)
AC_SUBST(NR_CPUS)
##########################################
# Check to enable/disable shared library
##########################################
AM_SHARED_LIBRARY_SUPPORT

##########################################
# Ada Util library
##########################################
AM_GNAT_FIND_PROJECT([ada-util],[Ada Utility Library],[utilada_sys],
  [git@github.com:stcarrez/ada-util.git],
  [Building asfbench requires the Ada Utility Library.],
  [
    UTIL_DIR=${gnat_project_dir_utilada_sys}
  ])
AC_SUBST(UTIL_DIR)

##########################################
# Ada Expression Language library
##########################################
AM_GNAT_FIND_PROJECT([ada-el],[Ada Expression Language Library],[elada],
  [git@github.com:stcarrez/ada-el.git],
  [Building asfbench requires the Ada EL Library.],
  [
    EL_DIR=${gnat_project_dir_elada}
  ])
AC_SUBST(EL_DIR)

##########################################
# Ada Servlet library
##########################################
AM_GNAT_FIND_PROJECT([ada-servlet],[Ada Servlet],[servletada],
  [git@github.com:stcarrez/ada-servlet.git],
  [Building asfbench requires the Ada Servlet Library.],
  [
    SERVLET_DIR=${gnat_project_dir_servletada}
  ])
AC_SUBST(SERVLET_DIR)

##########################################
# Ada Server Faces library
##########################################
AM_GNAT_FIND_PROJECT([ada-asf],[Ada Server Faces],[asf],
  [git@github.com:stcarrez/ada-asf.git],
  [Building asfbench requires the Ada Server Faces Library.],
  [
    ASF_DIR=${gnat_project_dir_asf}
  ])
AC_SUBST(ASF_DIR)

##########################################
# Ada Security library
##########################################
AM_GNAT_FIND_PROJECT([ada-security],[Ada Security Library],[security],
  [git@github.com:stcarrez/ada-security.git],
  [Building asfbench requires the Ada Security Library.],
  [
    SECURITY_DIR=${gnat_project_dir_security}
  ])
AC_SUBST(SECURITY_DIR)

AC_OUTPUT(
Makefile.conf
asfbench.gpr
)

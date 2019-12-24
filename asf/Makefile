NAME=asfbench

-include Makefile.conf

STATIC_MAKE_ARGS = $(MAKE_ARGS) -XHELIOS_LIBRARY_TYPE=static
SHARED_MAKE_ARGS = $(MAKE_ARGS) -XHELIOS_LIBRARY_TYPE=relocatable
SHARED_MAKE_ARGS += -XUTILADA_BASE_BUILD=relocatable -XUTIL_LIBRARY_TYPE=relocatable
SHARED_MAKE_ARGS += -XXMLADA_BUILD=relocatable
SHARED_MAKE_ARGS += -XLIBRARY_TYPE=relocatable

include Makefile.defaults

# Build and run the unit tests
test:	build
	# bin/helios_harness -xml helios-aunit.xml

$(eval $(call ada_library,$(NAME)))

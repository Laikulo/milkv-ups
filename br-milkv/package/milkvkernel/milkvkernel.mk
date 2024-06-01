################################################################################
#
## milkvkernel
#
################################################################################

MILKVKERNEL_VERSION = 1.0
MILKVKERNEL_SITE = $(MILKVKERNEL_PKGDIR)src
MILKVKERNEL_SITE_METHOD = local

define MILKVKERNEL_BUILD_CMDS
	echo "NOOP"
endef

define MILKVKERNEL_INSTALL_STAGING_CMDS
	echo "NOOP"
endef

define MILKVKERNEL_INSTALL_TARGET_CMDS
	echo "NOOP"
endef

$(eval $(generic-package))

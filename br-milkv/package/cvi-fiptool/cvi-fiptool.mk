CVI_FIPTOOL_VERSION = 7f59889c91f7d5d440d6a09aad0209f0aca3d09d
CVI_FIPTOOL_SITE = $(call github,sophgo,fiptool,$(CVI_FIPTOOL_VERSION))
HOST_CVI_FIPTOOL_DEPENDENCIES = host-python3

define CVI_FIPTOOL_BUILD_CMDS
        echo "NOOP"
endef

define CVI_FIPTOOL_INSTALL_STAGING_CMDS
        echo "NOOP"
endef

define CVI_FIPTOOL_INSTALL_TARGET_CMDS
        echo "NOOP"
endef

$(eval $(host-generic-package))

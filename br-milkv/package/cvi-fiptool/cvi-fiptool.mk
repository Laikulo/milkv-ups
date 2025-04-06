CVI_FIPTOOL_VERSION = 7f59889c91f7d5d440d6a09aad0209f0aca3d09d
CVI_FIPTOOL_SITE = $(call github,sophgo,fiptool,$(CVI_FIPTOOL_VERSION))
HOST_CVI_FIPTOOL_DEPENDENCIES = host-python3

define HOST_CVI_FIPTOOL_INSTALL_CMDS
	$(INSTALL) -m 755 $(@D)/fiptool $(HOST_DIR)/bin/cvi-fiptool
	$(INSTALL) -d $(HOST_DIR)/share/firmware/cvi/
	cp -a $(@D)/data/* $(HOST_DIR)/share/firmware/cvi/
endef

$(eval $(host-generic-package))

PYTHON_PINPONG_VERSION = 0.5.2
PYTHON_PINPONG_SITE = $(BR2_EXTERNAL_MILKV_PATH)/package/python-pinpong
PYTHON_PINPONG_SITE_METHOD = local

define PYTHON_PINPONG_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/python3.9/site-packages
	cp -af $(@D)/pinpong  $(TARGET_DIR)/usr/lib/python3.9/site-packages/
endef

$(eval $(generic-package))

LINUX_EXTENSIONS += milkvkernel

define MILKVKERNEL_PREPARE_KERNEL
    $(MILKVKERNEL_DIR)/apply.sh $(@D)
endef

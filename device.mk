
LOCAL_PATH := device/oneplus/avicii

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# define hardware platform
PRODUCT_PLATFORM := lito

AB_OTA_UPDATER := true

# A/B support
PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier


AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-impl-wrapper.recovery \
    android.hardware.boot@1.0-impl-wrapper \
    android.hardware.boot@1.0-impl-recovery \
    bootctrl.lito \
    bootctrl.lito.recovery \

TW_LOAD_VENDOR_MODULES := "touchscreen.ko aw8697.ko adsp_loader_dlkm.ko oplus_chg.ko"

# fastbootd
PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0-impl-mock \
	fastbootd \
        resetprop

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# tzdata
PRODUCT_PACKAGES_ENG += \
	tzdata_twrp

# qcom decryption
PRODUCT_PACKAGES_ENG += \
	qcom_decrypt \
	qcom_decrypt_fbe

# Apex libraries
PRODUCT_COPY_FILES += \
	$(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

#PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root)

#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := device/oneplus/avicii

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lito
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Needed for minimal-twrp-manifest
ALLOW_MISSING_DEPENDENCIES=true

# Kernel
BOARD_KERNEL_CMDLINE := \
	androidboot.hardware=qcom \
	androidboot.console=ttyMSM0 \
	androidboot.memcg=1 \
	lpm_levels.sleep_disabled=1 \
	video=vfb:640x400,bpp=32,memsize=3072000 \
	msm_rtb.filter=0x237 \
	service_locator.enable=1 \
	swiotlb=2048 \
	firmware_class.path=/vendor/firmware_mnt/image \
	androidboot.usbcontroller=a600000.dwc3 \
	androidboot.selinux=permissive

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE          := 0x00000000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_DTB_OFFSET           := 0x01f00000
TARGET_KERNEL_ARCH := arm64
TARGET_PREBUILT_DTB := $(LOCAL_PATH)/prebuilt/dtb.img
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/prebuilt/Image.gz
BOARD_PREBUILT_DTBOIMAGE := $(LOCAL_PATH)/prebuilt/dtbo.img
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)


# Platform
TARGET_BOARD_PLATFORM := lito
TARGET_BOARD_PLATFORM_GPU := qcom-adreno620
QCOM_BOARD_PLATFORMS += lito
TARGET_USES_HARDWARE_QCOM_BOOTCTRL := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_USES_PRODUCTIMAGE := true

BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 4096
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Dynamic/Logical Partitions
BOARD_SUPER_PARTITION_SIZE := 15032385536
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 7511998464
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    product \
    vendor \
    odm

TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab

# Workaround for error copying vendor files to recovery ramdisk
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_VBMETA_SYSTEM := system product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VBMETA_VENDOR := vendor odm
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 3

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_DEVICE_MODULES += \
	libion \
	libxml2

# TWRP specific build flags
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_SUPERSU := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
AB_OTA_UPDATER := true
TW_MAX_BRIGHTNESS := 1023
TW_DEFAULT_BRIGHTNESS := 420
TW_Y_OFFSET := 93
TW_H_OFFSET := -93
TW_THEME := portrait_hdpi
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TW_NO_SCREEN_BLANK := true
TW_USE_TOOLBOX := true
TW_NO_BIND_SYSTEM := true
TW_NO_EXFAT_FUSE := true
TW_SYSTEM_BUILD_PROP_ADDITIONAL_PATHS := etc/buildinfo/oem_build.prop
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    vbmeta \
    dtbo

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# Encryption
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
#TW_INCLUDE_CRYPTO := true
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true

# Extras
TW_INCLUDE_RESETPROP := true
BOARD_PROVIDES_GPTUTILS := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_USE_LEDS_HAPTICS := true
USE_RECOVERY_INSTALLER := true
TW_HAS_EDL_MODE := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_NO_USB_STORAGE := true
PLATFORM_VERSION := 127
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
TW_OVERRIDE_SYSTEM_PROPS := "ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.build.version.ota"

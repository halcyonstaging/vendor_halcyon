PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += halcyonVarsPlugin

SOONG_CONFIG_halcyonVarsPlugin :=

define addVar
  SOONG_CONFIG_halcyonVarsPlugin += $(1)
  SOONG_CONFIG_halcyonVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += halcyonGlobalVars
SOONG_CONFIG_halcyonGlobalVars += \
    additional_gralloc_10_usage_bits \
    camera_needs_client_info \
    camera_needs_client_info_lib \
    gralloc_handle_has_reserved_size \
    needs_camera_boottime \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_surfaceflinger_udfps_lib \
    target_trust_usb_control_path \
    target_trust_usb_control_enable \
    target_trust_usb_control_disable \
    uses_egl_display_array \
    needs_oplus_tag

SOONG_CONFIG_NAMESPACES += halcyonNvidiaVars
SOONG_CONFIG_halcyonNvidiaVars += \
    uses_nvidia_enhancements

SOONG_CONFIG_NAMESPACES += halcyonQcomVars
SOONG_CONFIG_halcyonQcomVars += \
    supports_extended_compress_format \
    uses_pre_uplink_features_netmgrd

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_halcyonQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_halcyonGlobalVars_camera_needs_client_info := $(TARGET_CAMERA_NEEDS_CLIENT_INFO)
SOONG_CONFIG_halcyonGlobalVars_camera_needs_client_info_lib := $(TARGET_CAMERA_NEEDS_CLIENT_INFO_LIB)
SOONG_CONFIG_halcyonGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_halcyonGlobalVars_uses_egl_display_array := $(TARGET_USES_EGL_DISPLAY_ARRAY)
SOONG_CONFIG_halcyonGlobalVars_needs_oplus_tag := $(TARGET_NEEDS_OPLUS_VENDOR_TAG)
SOONG_CONFIG_halcyonGlobalVars_needs_camera_boottime := $(TARGET_CAMERA_BOOTTIME_TIMESTAMP)
SOONG_CONFIG_halcyonNvidiaVars_uses_nvidia_enhancements := $(NV_ANDROID_FRAMEWORK_ENHANCEMENTS)
SOONG_CONFIG_halcyonQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_halcyonQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)

# Set default values
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
TARGET_TRUST_USB_CONTROL_PATH ?= /proc/sys/kernel/deny_new_usb
TARGET_TRUST_USB_CONTROL_ENABLE ?= 1
TARGET_TRUST_USB_CONTROL_DISABLE ?= 0

# Soong value variables
SOONG_CONFIG_halcyonGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_halcyonGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_halcyonGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_halcyonGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_halcyonGlobalVars_target_trust_usb_control_path := $(TARGET_TRUST_USB_CONTROL_PATH)
SOONG_CONFIG_halcyonGlobalVars_target_trust_usb_control_enable := $(TARGET_TRUST_USB_CONTROL_ENABLE)
SOONG_CONFIG_halcyonGlobalVars_target_trust_usb_control_disable := $(TARGET_TRUST_USB_CONTROL_DISABLE)
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_halcyonQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_halcyonQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif

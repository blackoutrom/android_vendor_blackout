# Vendor hack
#   $1 = vendor name
#   $2 = product name
define vendor-replace
  $(shell mkdir -p vendor/$(1); \
          rm -rf vendor/$(1)/$(2); \
          ln -sf ../$(1)-extra/$(2) vendor/$(1)/$(2))
endef

# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Blackout ROM Packages
PRODUCT_PACKAGES += \
    GooManager

PRODUCT_COPY_FILES += \
    vendor/blackout/prebuilt/common/apk/novalauncher.apk:system/app/novalauncher.apk \
    vendor/blackout/prebuilt/common/apk/titanium.apk:system/app/titanium.apk

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/blackout/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/blackout/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/blackout/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# Using Custom ReleaseRool
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := vendor/blackout/overlay/build/tools/releasetools/ota_from_target_files

# T-Mobile theme engine
include vendor/blackout/config/themes_common.mk

# init.d support
PRODUCT_COPY_FILES += \
    vendor/blackout/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/blackout/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/blackout/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/blackout/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/blackout/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/blackout/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/blackout/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/blackout/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/blackout/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/blackout/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/blackout/prebuilt/common/etc/init.d/11battery:system/etc/init.d/11battery \
    vendor/blackout/prebuilt/common/etc/init.d/12touch:system/etc/init.d/12touch \
    vendor/blackout/prebuilt/common/etc/init.d/13minfree:system/etc/init.d/13minfree \
    vendor/blackout/prebuilt/common/etc/init.d/14gpurender:system/etc/init.d/14gpurender \
    vendor/blackout/prebuilt/common/etc/init.d/15sleepers:system/etc/init.d/15sleepers \
    vendor/blackout/prebuilt/common/etc/init.d/16journalism:system/etc/init.d/16journalism \
    vendor/blackout/prebuilt/common/etc/init.d/17sqlite3:system/etc/init.d/17sqlite3 \
    vendor/blackout/prebuilt/common/etc/init.d/18wifisleep:system/etc/init.d/18wifisleep \
    vendor/blackout/prebuilt/common/etc/init.d/19iostats:system/etc/init.d/19iostats \
    vendor/blackout/prebuilt/common/etc/init.d/20setrenice:system/etc/init.d/20setrenice \
    vendor/blackout/prebuilt/common/etc/init.d/21tweaks:system/etc/init.d/21tweaks \
    vendor/blackout/prebuilt/common/etc/init.d/24speedy_modified:system/etc/init.d/24speedy_modified \
    vendor/blackout/prebuilt/common/etc/init.d/25loopy_smoothness_tweak:system/etc/init.d/25loopy_smoothness_tweak \
    vendor/blackout/prebuilt/common/etc/init.d/98tweaks:system/etc/init.d/98tweaks \
    vendor/blackout/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/blackout/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/blackout/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/blackout/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/blackout/prebuilt/common/xbin/zipalign:system/xbin/zipalign

# Blackout ROM Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/blackout/overlay/blackout/common

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/blackout/CHANGELOG.mkdn:system/etc/BLK-CHANGELOG.txt \
    vendor/blackout/CONTRIBUTORS.mkdn:system/etc/BLK-CONTRIBUTORS.txt

# AOKP Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/blackout/overlay/aokp/common

BOARD := $(subst blk_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# Blackout ROM version
BLK_VERSION_MAJOR = 0
BLK_VERSION_MINOR = 1
BLK_VERSION_MAINTENANCE = Beta
BLK_VERSION := $(BLK_VERSION_MAJOR).$(BLK_VERSION_MINOR).$(BLK_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.blk.version=$(BLK_VERSION) \
    ro.blkrom.version=blk_$(BOARD)_$(BLK_VERSION)_$(shell date +%Y%m%d-%H%M%S) \

# ROMStats Properties
#PRODUCT_PROPERTY_OVERRIDES += \
#    ro.blkstats.url=http://stats.blackoutrom.com \
#    ro.blkstats.name=Blackout \
#    ro.blkstats.version=$(BLK_VERSION) \
#    ro.blkstats.tframe=1

# Disable ADB authentication and set root access to Apps and ADB
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    persist.sys.root_access=3

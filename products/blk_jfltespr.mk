# Check for target product
ifeq (blk_jfltespr,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xxhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/blackout/overlay/aokp/device/jfltexxx

# Blackout ROM boot logo
#PRODUCT_COPY_FILES += \
#    vendor/blackout/prebuilt/common/bootlogo/blk_logo_1080x1920.rle:root/logo.rle
#    $(shell cp -f vendor/blackout/prebuilt/common/bootanimation_framework/android-logo-mask_samsung-xhdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# Copy bootanimation
#PRODUCT_COPY_FILES += \
#    vendor/blackout/prebuilt/xxhdpi/bootanimation.zip:system/media/bootanimation.zip

# include Blackout ROM common configuration
include vendor/blackout/config/blk_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/jfltespr/cm.mk)

PRODUCT_NAME := blk_jfltespr

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/blackout/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/blackout/tools/addprojects.py $(PRODUCT_NAME))

endif

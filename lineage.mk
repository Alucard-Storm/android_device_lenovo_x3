#
# Copyright (C) 2018 The Lineage Open Source Project
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

# Boot animation
TARGET_BOOTANIMATION_SIZE := 1080p
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920

# Inherit 64-bit configs
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common omni stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lenovo/x3/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_NAME := lineage_x3
PRODUCT_DEVICE := x3

PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := x3
PRODUCT_MANUFACTURER := Lenovo

PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=x3

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

PRODUCT_BUILD_PROP_OVERRIDES += \
	PRIVATE_BUILD_DESC="X3c70-user 6.0.1 MMB29M VIBEUI_V3.1_1626_5.611.1_ST_X3c70 release-keys"

BUILD_FINGERPRINT := Lenovo/X3c70/X3c70:6.0.1/MMB29M/VIBEUI_V3.1_1626_5.611.1_ST_X3c70:user/release-keys

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Power
PRODUCT_PACKAGES += \
    power.msm8992

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/perf-profiles/perf-profile0.conf:system/vendor/etc/perf-profile0.conf \
    $(LOCAL_PATH)/configs/perf-profiles/perf-profile1.conf:system/vendor/etc/perf-profile1.conf \
    $(LOCAL_PATH)/configs/perf-profiles/perf-profile2.conf:system/vendor/etc/perf-profile2.conf \
    $(LOCAL_PATH)/configs/perf-profiles/perf-profile3.conf:system/vendor/etc/perf-profile3.conf \
    $(LOCAL_PATH)/configs/perf-profiles/perf-profile4.conf:system/vendor/etc/perf-profile4.conf \
    $(LOCAL_PATH)/configs/perf-profiles/perf-profile5.conf:system/vendor/etc/perf-profile5.conf
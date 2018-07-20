PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config \
    $(LOCAL_PATH)/configs/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

PRODUCT_PACKAGES += \
    libtinyxml

# IMS Shim
PRODUCT_PACKAGES += \
    libshims_ims \
    libshim_ims-camera
# try not to use big cores during dexopt
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.boot-dex2oat-threads=4 \
    dalvik.vm.dex2oat-threads=4 \
    dalvik.vm.image-dex2oat-threads=4

# Enable sdcardfs
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.sdcardfs=true
    
# ADB
PRODUCT_PROPERTY_OVERRIDES += \
	ro.adb.secure=0 \
	ro.secure=0 \
	ro.allow.mock.location=1 \
	persist.service.adb.enable=1 \
	persist.service.debuggable=1 \
	persist.sys.usb.config=mtp,adb
	
# MTP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lenovo.series=Lenovo X3

LOCAL_PATH := $(call my-dir)
ifeq ($(TW_INCLUDE_CRYPTO), true)
include $(CLEAR_VARS)

LOCAL_MODULE := libcryptfsfde
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := cryptfs.cpp
LOCAL_SHARED_LIBRARIES := libcrypto libhardware libcutils
LOCAL_STATIC_LIBRARIES := libscrypttwrp_static
LOCAL_C_INCLUDES := external/openssl/include $(commands_recovery_local_path)/crypto/scrypt/lib/crypto

#8.0 or higher
LOCAL_C_INCLUDES +=  external/boringssl/src/include
LOCAL_SHARED_LIBRARIES += libselinux libc libc++ libbase libcrypto libcutils libkeymaster_messages libhardware libprotobuf-cpp-lite libe4crypt android.hardware.keymaster@3.0 libkeystore_binder libhidlbase libutils libbinder
#9.0 rules
LOCAL_CFLAGS += -Wno-unused-variable -Wno-sign-compare -Wno-unused-parameter -Wno-comment
LOCAL_SHARED_LIBRARIES += android.hardware.keymaster@4.0 libkeymaster4support libkeyutils
LOCAL_CFLAGS += -DTW_KEYMASTER_MAX_API=4
ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
    ifeq ($(TARGET_CRYPTFS_HW_PATH),)
        LOCAL_C_INCLUDES += device/qcom/common/cryptfs_hw
    else
        LOCAL_C_INCLUDES += $(TARGET_CRYPTFS_HW_PATH)
    endif
    LOCAL_SHARED_LIBRARIES += libcryptfs_hw
    LOCAL_CFLAGS += -DCONFIG_HW_DISK_ENCRYPTION
endif

include $(BUILD_SHARED_LIBRARY)



include $(CLEAR_VARS)
LOCAL_MODULE := twrpdec
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := main.cpp cryptfs.cpp
LOCAL_SHARED_LIBRARIES := libcrypto libhardware libcutils libc
LOCAL_C_INCLUDES := external/openssl/include $(commands_recovery_local_path)/crypto/scrypt/lib/crypto

#8.0 or higher
LOCAL_C_INCLUDES +=  external/boringssl/src/include
LOCAL_SHARED_LIBRARIES += libselinux libc libc++ libbase libcrypto libcutils libkeymaster_messages libhardware libprotobuf-cpp-lite libe4crypt android.hardware.keymaster@3.0 libkeystore_binder libhidlbase libutils libbinder
#9.0 rules
LOCAL_CFLAGS += -Wno-unused-variable -Wno-sign-compare -Wno-unused-parameter -Wno-comment
LOCAL_SHARED_LIBRARIES += android.hardware.keymaster@4.0 libkeymaster4support libkeyutils
LOCAL_CFLAGS += -DTW_KEYMASTER_MAX_API=4
ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
    ifeq ($(TARGET_CRYPTFS_HW_PATH),)
        LOCAL_C_INCLUDES += device/qcom/common/cryptfs_hw
    else
        LOCAL_C_INCLUDES += $(TARGET_CRYPTFS_HW_PATH)
    endif
    LOCAL_SHARED_LIBRARIES += libcryptfs_hw
    LOCAL_CFLAGS += -DCONFIG_HW_DISK_ENCRYPTION
endif

LOCAL_WHOLE_STATIC_LIBRARIES += libscrypttwrp_static
include $(BUILD_EXECUTABLE)

endif

LOCAL_PATH := $(call my-dir)
ifeq ($(TW_INCLUDE_CRYPTO), true)
include $(CLEAR_VARS)

LOCAL_MODULE := libe4crypt
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS :=
LOCAL_SRC_FILES := Decrypt.cpp ScryptParameters.cpp Utils.cpp HashPassword.cpp ext4_crypt.cpp
LOCAL_SHARED_LIBRARIES := libselinux libc libc++ libext4_utils libbase libcrypto libcutils libkeymaster_messages libhardware libprotobuf-cpp-lite
LOCAL_STATIC_LIBRARIES := libscrypt_static
LOCAL_C_INCLUDES := system/extras/ext4_utils \
    system/extras/ext4_utils/include/ext4_utils \
    external/scrypt/lib/crypto \
    system/security/keystore/include \
    hardware/libhardware/include/hardware \
    system/security/softkeymaster/include/keymaster \
    system/keymaster/include

ifneq ($(wildcard hardware/libhardware/include/hardware/keymaster0.h),)
    LOCAL_CFLAGS += -DTW_CRYPTO_HAVE_KEYMASTERX
    LOCAL_C_INCLUDES +=  external/boringssl/src/include
endif
#8.0 or higher
LOCAL_CFLAGS += -DHAVE_GATEKEEPER1
LOCAL_SHARED_LIBRARIES += android.hardware.confirmationui@1.0
# LOCAL_CFLAGS += -DUSE_
LOCAL_SHARED_LIBRARIES += android.hardware.keymaster@3.0 libkeystore_binder libhidlbase libutils libbinder android.hardware.gatekeeper@1.0
#9.0 rules
LOCAL_CFLAGS += -DUSE_KEYSTORAGE_4 -Wno-unused-variable -Wno-sign-compare -Wno-unused-parameter -Wno-comment
LOCAL_SRC_FILES += Ext4CryptPie.cpp Keymaster4.cpp KeyStorage4.cpp KeyUtil.cpp MetadataCrypt.cpp KeyBuffer.cpp
LOCAL_SHARED_LIBRARIES += android.hardware.keymaster@4.0 libkeymaster4support
LOCAL_SHARED_LIBRARIES += android.hardware.gatekeeper@1.0 libkeystore_parcelables libkeystore_aidl
LOCAL_CFLAGS += -DHAVE_SYNTH_PWD_SUPPORT
LOCAL_SRC_FILES += Weaver1.cpp
LOCAL_SHARED_LIBRARIES += android.hardware.weaver@1.0
LOCAL_CFLAGS += -DHAVE_LIBKEYUTILS
LOCAL_SHARED_LIBRARIES += libkeyutils
LOCAL_REQUIRED_MODULES := keystore_auth

include $(BUILD_SHARED_LIBRARY)



include $(CLEAR_VARS)
LOCAL_MODULE := twrpfbe
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := main.cpp
LOCAL_SHARED_LIBRARIES := libe4crypt
#LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := e4policyget
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := e4policyget.cpp
LOCAL_SHARED_LIBRARIES := libe4crypt
LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := keystore_auth
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := keystore_auth.cpp
LOCAL_SHARED_LIBRARIES := libc libkeystore_binder libutils libbinder liblog
#9.0
LOCAL_CFLAGS += -DUSE_SECURITY_NAMESPACE
LOCAL_SHARED_LIBRARIES += libkeystore_aidl
LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64

include $(BUILD_EXECUTABLE)

endif

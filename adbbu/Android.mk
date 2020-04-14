LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libtwadbbu
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS = -fno-strict-aliasing -D_LARGFILE_SOURCE #-D_DEBUG_ADB_BACKUP
LOCAL_C_INCLUDES += bionic external/zlib

LOCAL_SRC_FILES = \
        libtwadbbu.cpp \
        twrpback.cpp

LOCAL_SHARED_LIBRARIES += libz libc libtwrpdigest

LOCAL_SHARED_LIBRARIES += libc++

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
        adbbumain.cpp

LOCAL_SHARED_LIBRARIES += libz libtwadbbu

LOCAL_SHARED_LIBRARIES += libc++

LOCAL_C_INCLUDES += bionic external/zlib
LOCAL_CFLAGS:= -c -W
LOCAL_MODULE:= twrpbu
LOCAL_MODULE_STEM := bu
LOCAL_MODULE_TAGS:= optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_EXECUTABLE)


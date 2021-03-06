LOCAL_PATH := $(call my-dir)

RELINK := $(LOCAL_PATH)/relink.sh

#dummy file to trigger required modules
include $(CLEAR_VARS)

LOCAL_MODULE := teamwin
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin

# Manage list
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/dump_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/flash_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/erase_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/bu

RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/sh
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/grep
LOCAL_POST_INSTALL_CMD += $(hide) if [ -e "$(TARGET_RECOVERY_ROOT_OUT)/sbin/egrep" ]; then \
                            rm $(TARGET_RECOVERY_ROOT_OUT)/sbin/egrep; fi; ln -s $(TARGET_RECOVERY_ROOT_OUT)/sbin/grep $(TARGET_RECOVERY_ROOT_OUT)/sbin/egrep; \
                            if [ -e "$(TARGET_RECOVERY_ROOT_OUT)/sbin/fgrep" ]; then \
                            rm $(TARGET_RECOVERY_ROOT_OUT)/sbin/fgrep; fi; ln -s $(TARGET_RECOVERY_ROOT_OUT)/sbin/grep $(TARGET_RECOVERY_ROOT_OUT)/sbin/fgrep;
ifneq ($(wildcard external/zip/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/zip
endif
ifneq ($(wildcard external/unzip/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/unzip
endif
ifneq ($(wildcard system/core/libziparchive/Android.bp),)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/unzip
endif
ifneq ($(wildcard external/one-true-awk/Android.bp),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/awk
endif

RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/pigz
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/fsck.fat
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/fatlabel
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/mkfs.fat
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/adbd
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/e2fsck
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/e2fsdroid
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mke2fs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/tune2fs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/resize2fs
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/simg2img
ifneq ($(TARGET_ARCH), x86_64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker
endif
ifeq ($(TARGET_ARCH), x86_64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker64
endif
ifeq ($(TARGET_ARCH), arm64)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/linker64
endif
#RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/twrpmtp
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libc.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libdl.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libm.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libbootloader_message.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libfs_mgr.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libfscrypt.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libgsi.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libkeyutils.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/liblogwrap.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/liblp.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libprocessgroup.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libprocessgroup_setup.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libadbd.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libadbd_services.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libcap.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libminijail.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libunwindstack.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libasyncio.so
RELINK_SOURCE_FILES += $(TARGET_ROOT_OUT)/../system/lib64/libinit.so
RELINK_SOURCE_FILES += $(TARGET_ROOT_OUT)/../system/lib64/libdl_android.so
RELINK_SOURCE_FILES += $(TARGET_ROOT_OUT)/../system/lib64/libprotobuf-cpp-lite.so
RELINK_SOURCE_FILES += $(TARGET_ROOT_OUT)/../system/lib64/libbinder.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/toybox
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrecovery.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libusbhost.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_com_err.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_e2p.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_profile.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_uuid.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_misc.so
ifneq ($(wildcard external/e2fsprogs/lib/quota/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_quota.so
endif
ifneq ($(wildcard external/e2fsprogs/lib/ext2fs/Android.*),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
endif
ifneq ($(wildcard external/e2fsprogs/lib/blkid/Android.*),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_blkid.so
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpng.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblog.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libz.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminuitwrp.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminadbd.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtar.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwadbbu.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwrpdigest.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutil-linux.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libblkid.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfusesideload.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbootloader_message_twrp.so

RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so \
$(if $(WITH_CRYPTO_UTILS),$(TARGET_OUT_SHARED_LIBRARIES)/libcrypto_utils.so)
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpackagelistparser.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblzma.so
# Android M libraries
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libbacktrace.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libunwind.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbase.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libc++.so
# Dynamically loaded by libc and may prevent unmounting system if it is not present in sbin
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libnetd_client.so
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/toolbox

ifneq ($(TW_OEM_BUILD),true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrp
else
    TW_EXCLUDE_MTP := true
endif

ifneq ($(TW_EXCLUDE_MTP), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwrpmtp-ffs.so
endif

RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext4_utils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libaosprecovery.so
ifneq ($(TW_INCLUDE_JPEG),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libjpeg.so
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libselinux.so
ifeq ($(BUILD_ID), GINGERBREAD)
    TW_NO_EXFAT := true
endif
ifneq ($(TW_NO_EXFAT), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/mkexfatfs
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/fsck.exfat
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexfat_twrp.so
else
    TW_NO_EXFAT_FUSE := true
endif
ifneq ($(TW_NO_EXFAT_FUSE), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/exfat-fuse
endif
ifeq ($(TW_INCLUDE_BLOBPACK), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/blobpack
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcryptfsfde.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libgpt_twrp.so
    ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
        ifeq ($(TARGET_CRYPTFS_HW_PATH),)
            RELINK_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libcryptfs_hw.so
        else
            RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcryptfs_hw.so
        endif
    endif
    # FBE files
    ifeq ($(TW_INCLUDE_CRYPTO_FBE), true)
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libe4crypt.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libgatekeeper.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_messages.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore_binder.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbinder.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libprotobuf-cpp-lite.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsoftkeymasterdevice.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.gatekeeper@1.0.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/hwservicemanager
        RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/avbctl
        RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore
        RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/keystore_cli
        RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/servicemanager
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.wifi.keystore@1.0.so
        ifneq ($(wildcard system/keymaster/keymaster_stl.cpp),)
            RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_portable.so
            RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_staging.so
        endif
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libwifikeystorehal.so
        ifneq ($(wildcard hardware/interfaces/weaver/Android.bp),)
            RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.weaver@1.0.so
        endif
        ifneq ($(wildcard hardware/interfaces/weaver/1.0/Android.bp),)
            RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.weaver@1.0.so
        endif
        ifneq ($(wildcard hardware/interfaces/confirmationui/1.0/Android.bp),)
            RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.confirmationui@1.0.so
        endif

        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware_legacy.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.0.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4support.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore_aidl.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeystore_parcelables.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutilscallstack.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libunwindstack.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdexfile.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libservices.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_portable.so
         # lshal can be useful for seeing if you have things like the keymaster working properly, but it isn't needed for TWRP to work
         #RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/lshal
         #RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblshal.so
         #RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libssl.so
         #RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidl-gen-hash.so
    endif
endif
ifeq ($(AB_OTA_UPDATER), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/system/bin/update_engine_sideload
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.0.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/bootctl
    ifneq ($(TW_INCLUDE_CRYPTO), true)
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware.so
    endif
endif
ifneq ($(wildcard system/core/libsparse/Android.*),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsparse.so
endif
ifneq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/openaes
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libopenaes.so
endif
ifeq ($(TARGET_USERIMAGES_USE_F2FS), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/make_f2fs
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/sload_f2fs
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.f2fs
endif
ifneq ($(wildcard system/core/reboot/Android.*),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/reboot
endif
ifneq ($(TW_DISABLE_TTF), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libft2.so
endif
ifneq ($(TW_RECOVERY_ADDITIONAL_RELINK_FILES),)
    RELINK_SOURCE_FILES += $(TW_RECOVERY_ADDITIONAL_RELINK_FILES)
endif
ifneq ($(wildcard external/pcre/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcre.so
endif
ifeq ($(TW_INCLUDE_NTFS_3G),true)
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mount.ntfs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.ntfs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mkfs.ntfs
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libntfs-3g.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfuse-lite.so
endif
ifeq ($(BOARD_HAS_NO_REAL_SDCARD),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/sgdisk
endif
ifeq ($(TWRP_INCLUDE_LOGCAT), true)
    RELINK_SOURCE_FILES += $(TARGET_ROOT_OUT)/../system/bin/logcat
    ifeq ($(TARGET_USES_LOGD), true)
        RELINK_SOURCE_FILES += $(TARGET_ROOT_OUT)/../system/bin/logd
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsysutils.so
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libnl.so
    endif
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblogcat.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcre2.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libvndksupport.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhwbinder.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidlbase.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidltransport.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@3.0.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libziparchive.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_blkid.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_quota.so

RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhidl-gen-utils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libvintf.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtinyxml2.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.token@1.0.so
ifneq ($(wildcard system/core/libkeyutils/Android.bp),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libkeyutils.so
endif
ifeq ($(wildcard system/libhidl/transport/HidlTransportUtils.cpp),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so
endif
ifeq ($(TARGET_ARCH), arm64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-aarch64-android.so
endif
ifeq ($(TARGET_ARCH), arm)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-arm-android.so
endif
ifeq ($(TARGET_ARCH), x86_64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-x86_64-android.so
endif
ifeq ($(TARGET_ARCH), x86)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-i686-android.so
endif
ifeq ($(TARGET_ARCH), mips)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-mips-android.so
endif
ifeq ($(TARGET_ARCH), mips64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libclang_rt.ubsan_standalone-mips64-android.so
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblogwrap.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_misc.so

#toybox links
toybox_links := acpi base64 basename bc blockdev cal cat chcon chgrp chmod chown chroot chrt cksum clear \
    cmp comm cp cpio cut date dd devmem df diff dirname dmesg dos2unix du echo env expand expr fallocate \
    false file find flock fmt free fsync getconf getenforce groups gunzip gzip head hostname hwclock i2cdetect \
    i2cdump i2cget i2cset iconv id ifconfig inotifyd insmod install ionice iorenice kill killall ln load_policy \
    log logname losetup ls lsmod lsof lspci lsusb md5sum microcom mkdir mkfifo mknod mkswap mktemp modinfo modprobe \
    more mount mountpoint mv nc netcat netstat nice nl nohup nproc nsenter od paste patch pgrep pidof pkill pmap \
    printenv printf ps pwd readlink realpath renice restorecon rm rmdir rmmod runcon sed sendevent seq setenforce \
    setprop setsid sha1sum sha224sum sha256sum sha384sum sha512sum sleep sort split start stat stop strings stty \
    swapoff swapon sync sysctl tac tail tar taskset tee time timeout top touch tr true truncate tty ulimit \
    umount uname uniq unix2dos unlink unshare uptime usleep uudecode uuencode uuidgen vmstat watch wc which whoami \
    xargs xxd yes zcat
TOYBOX_LINKS := $(addprefix $(TARGET_RECOVERY_ROOT_OUT)/system/bin/, $(toybox_links))

#relink recovery executables linker to /sbin and move symlinks
include $(CLEAR_VARS)
LOCAL_MODULE := relink
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/sbin $(RELINK_SOURCE_FILES) && \
    mv $(TOYBOX_LINKS) $(TARGET_RECOVERY_ROOT_OUT)/sbin/
LOCAL_REQUIRED_MODULES := linker adbd libdl_android toybox
include $(BUILD_PHONY_PACKAGE)

#relink init
include $(CLEAR_VARS)
LOCAL_MODULE := relink_init
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
RELINK_INIT := $(TARGET_RECOVERY_ROOT_OUT)/system/bin/init
LOCAL_POST_INSTALL_CMD += $(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/ $(RELINK_INIT) && \
    mv $(TARGET_RECOVERY_ROOT_OUT)/system/bin/ueventd $(TARGET_RECOVERY_ROOT_OUT)/sbin/
LOCAL_REQUIRED_MODULES := init_second_stage.recovery
include $(BUILD_PHONY_PACKAGE)

ifeq ($(BOARD_HAS_NO_REAL_SDCARD),)
	#parted
	#include $(CLEAR_VARS)
	#LOCAL_MODULE := parted
	#LOCAL_MODULE_TAGS := optional
	#LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	#LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
	#LOCAL_SRC_FILES := $(LOCAL_MODULE)
	#include $(BUILD_PREBUILT)
endif

# copy license file for OpenAES
ifneq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := openaes_license
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/license/openaes
	LOCAL_SRC_FILES := ../openaes/LICENSE
	include $(BUILD_PREBUILT)
endif

ifeq ($(TW_USE_TOOLBOX), true)
   include $(CLEAR_VARS)
   LOCAL_MODULE := mkshrc_twrp
   LOCAL_MODULE_STEM := mkshrc
   LOCAL_MODULE_TAGS := optional
   LOCAL_MODULE_CLASS := ETC
   LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/etc
   LOCAL_SRC_FILES := $(LOCAL_MODULE)
   include $(BUILD_PREBUILT)
endif

#TWRP App "placeholder"
include $(CLEAR_VARS)
LOCAL_MODULE := me.twrp.twrpapp.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

ifeq ($(TW_INCLUDE_CRYPTO), true)
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),)
        # Prebuilt vdc_pie for pre-Pie SDK Platforms
        include $(CLEAR_VARS)
        LOCAL_MODULE := vdc_pie
        LOCAL_MODULE_TAGS := optional
        LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
        LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
        LOCAL_SRC_FILES := vdc_pie-$(TARGET_ARCH)
        include $(BUILD_PREBUILT)
    endif
endif

ifneq (,$(filter $(TW_INCLUDE_REPACKTOOLS) $(TW_INCLUDE_RESETPROP), true))
    ifeq ($(wildcard external/magisk-prebuilt/Android.mk),)
        $(warning Magisk prebuilt tools not found!)
        $(warning Please place https://github.com/TeamWin/external_magisk-prebuilt)
        $(warning into external/magisk-prebuilt)
        $(error magiskboot prebuilts not present; exiting)
    endif
endif

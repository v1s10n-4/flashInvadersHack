ARCHS = arm64e
TARGET = iphone:clang:12.1:12.1
SDK = iPhoneOS12.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = flashinvadershackprefs

flashinvadershackprefs_FILES = FIHRootListController.m
flashinvadershackprefs_INSTALL_PATH = /Library/PreferenceBundles
flashinvadershackprefs_FRAMEWORKS = UIKit
flashinvadershackprefs_PRIVATE_FRAMEWORKS = Preferences
flashinvadershackprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/flashinvadershackprefs.plist$(ECHO_END)

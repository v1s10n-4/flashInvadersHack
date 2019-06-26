include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = flashInvadersHackPrefs

flashInvadersHackPrefs_FILES = FIHRootListController.m
flashInvadersHackPrefs_INSTALL_PATH = /Library/PreferenceBundles
flashInvadersHackPrefs_FRAMEWORKS = UIKit
flashInvadersHackPrefs_PRIVATE_FRAMEWORKS = Preferences
flashInvadersHackPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/flashInvadersHackPrefs.plist$(ECHO_END)

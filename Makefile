ARCHS = arm64e
THEOS_DEVICE_IP = 10.1.0.122
THEOS_DEVICE_PORT = 22
TARGET = iphone:clang:12.1:12.1
SDK = iPhoneOS12.1

INSTALL_TARGET_PROCESSES = FlashInvaders

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = flashInvadersHack

flashInvadersHack_FRAMEWORKS = UIKit
flashInvadersHack_FILES = Tweak.x
flashInvadersHack_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += flashinvadershackprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

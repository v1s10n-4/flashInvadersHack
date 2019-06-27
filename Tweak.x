#define PLIST_PATH @"/var/mobile/Library/Preferences/com.v1s10n4.flashinvadershackprefs.plist"

static NSString *GetPrefString(NSString *key) {
    return [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key];
}

static bool GetPrefBool(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

static CGFloat GetPrefFloat(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

@implementation UIImage (Crop)
- (UIImage *)crop:(CGRect)rect {

    rect = CGRectMake(rect.origin.x*self.scale, 
                      rect.origin.y*self.scale, 
                      rect.size.width*self.scale, 
                      rect.size.height*self.scale);       

    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef 
                                          scale:self.scale 
                                    orientation:self.imageOrientation]; 
    CGImageRelease(imageRef);
    return result;
}
@end

%hook SICameraView
- (void)setImageTmp:(UIImage *)id {
	NSString *url = GetPrefString(GetPrefBool(@"useImage") ? @"imageUrl" : @"photoUrl");
	NSLog(@"%@", url);
	UIImage *image = [UIImage imageWithData: [
		NSData dataWithContentsOfURL: [
			NSURL URLWithString: url
		]
	]];
	if (!GetPrefBool(@"useImage")) {
		CGRect cropRect = CGRectMake(GetPrefFloat(@"x"), GetPrefFloat(@"y"), GetPrefFloat(@"width"), GetPrefFloat(@"height"));
		image = [image crop:cropRect];
	}
	NSLog(@"original: %@", id);
	NSLog(@"custom: %@", image);
	%orig(GetPrefBool(@"enabled") ? image : id);
}
%end

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.v1s10n4.flashinvadershackprefs.plist"

// static NSString *GetPrefString(NSString *key) {
//     return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] stringValue];
// }

%hook SICameraView

- (void)setImageTmp:(UIImage *)id {
	NSLog(@"%@", [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"imageUrl"]);
	// NSLog(@"%@",GetPrefString(@"imageUrl"));
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"imageUrl"]]]];
	// NSLog(@"custom: %@", image);
	%orig(image);
}

%end

// %hook AFImageCache

// - (id)cachedImageForRequest:(NSString *)

// %end
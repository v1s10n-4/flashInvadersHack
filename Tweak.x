#define kBundlePath @"/Library/Application Support/DynamicLibraries/flashInvadersHackBundle.bundle"
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.v1s10n4.flashinvadershackprefs.plist"
#import <CoreLocation/CoreLocation.h>

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
- (id)formatImage:(id)id {
	NSString *url = GetPrefString(GetPrefBool(@"useImage") ? @"imageUrl" : @"photoUrl");
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
	return %orig(GetPrefBool(@"enabled") ? image : id);
}
%end

%hook SIActionView
- (CLLocationCoordinate2D)coordinate {

	NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
	NSString* jsonPath = [bundle pathForResource:@"locations" ofType:@"json"];
	NSString* jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
	NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
	NSDictionary *arrayResult;
	for (int i = 0; i < [object count]; i++) {
		arrayResult = [object objectAtIndex:i];
		if ([[arrayResult objectForKey:@"url"] isEqualToString:GetPrefString(GetPrefBool(@"useImage") ? @"imageUrl" : @"photoUrl")])
			break;
	}
	if (error)
		NSLog(@"error: %@", error);
	CLLocationCoordinate2D coords = {[[arrayResult objectForKey:@"latitude"] doubleValue], [[arrayResult objectForKey:@"longitude"] doubleValue]};
	return GetPrefBool(@"enabled") ? coords : %orig;
}
%end

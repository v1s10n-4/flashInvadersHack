%hook SICameraView

- (void)setImageTmp:(UIImage *)id {
	// NSData *pngData = [NSData dataWithContentsOfFile:@"PA_01-1.jpg"];
	UIImage *image = [UIImage imageNamed:@"PA_01-1.jpg"];
	NSLog(@"pngData: %@", [UIImage imageNamed:@"PA_01-1.jpg"]);
	NSLog(@"original: %@", id);
	NSLog(@"custom: %@", image);
	%orig(image);
}

%end

// %hook AFImageCache

// - (id)cachedImageForRequest:(NSString *)

// %end
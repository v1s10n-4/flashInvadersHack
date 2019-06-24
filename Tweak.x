%hook SICameraView

- (void)setImageTmp:(UIImage *)id {
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://invader.spotter.free.fr/images/AIX_01-grosplan.png"]]];
	NSLog(@"pngData: %@", [UIImage imageNamed:@"PA_01-1.jpg"]);
	NSLog(@"original: %@", id);
	NSLog(@"custom: %@", image);
	%orig(image);
}

%end

// %hook AFImageCache

// - (id)cachedImageForRequest:(NSString *)

// %end
#import <Cocoa/Cocoa.h>

int main(int argc, char **argv)
{
	[NSAutoreleasePool new];
	NSFileManager *fm = [NSFileManager defaultManager];

	for (unsigned i=1 ; i<argc ; i++)
	{
		NSString *path = [fm currentDirectoryPath];
		NSString *file = [NSString stringWithUTF8String: argv[i]];
		path = [path stringByAppendingPathComponent: file];

		NSPasteboard *pboard = [NSPasteboard pasteboardWithUniqueName];

		[pboard declareTypes: [NSArray arrayWithObject: NSStringPboardType]
					   owner: nil];
		[pboard setString: path
				  forType: NSStringPboardType];

		NSPerformService(@"Finder/Show Info", pboard);
	}
	
	return 0;
}

#import <Foundation/Foundation.h>

@interface SimpleLoader : NSObject {}
+ (BOOL) loadFramework: (NSString*)framework
@end

@implementation SimpleLoader
+ (BOOL) loadFramework: (NSString*)framework
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray *dirs = 
		NSSearchPathForDirectoriesInDomains(
			NSLibraryDirectory,
			NSAllDomainsMask, 
			YES);
	FOREACH(dirs, dir, NSString*)
	{
		NSString *f = 
			[[[dir stringByAppendingPathComponent: @"Frameworks"]
				stringByAppendingPathComponent: framework]
					stringByAppendingPathExtension: @"framework"];
		// Check that the framework exists and is a directory.
		BOOL isDir = NO;
		if ([fm fileExistsAtPath: f isDirectory: &isDir] 
			&& isDir)
		{
			NSBundle *bundle = [NSBundle bundleWithPath: f];
			if ([bundle load]) 
			{
				NSLog(@"Loaded bundle %@", f);
				return YES;
			}
		}
	}
	return NO;
}
@end

#import "AppDelegate.h"

@implementation AppDelegate
- (BOOL)application: (NSApplication*)sender
 delegateHandlesKey: (NSString*)key
{
	if ([@"orderedDocuments" isEqualToString: key])
	{
		return YES;
	}
	return NO;
}
- (NSArray*) orderedDocuments
{
	return [NSArray arrayWithObject: model];
}
@end

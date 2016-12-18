#import "OutlineItem.h"

@implementation OutlineItem
@synthesize children;
@synthesize title;
- (id)init
{
    if (nil == (self = [super init]))
	{
		return nil;
    }
	children = [NSMutableArray new];
	title = @"New Item";
	return self;
}
- (void) dealloc
{
	[children release];
	[title release];
	[super dealloc];
}
@end

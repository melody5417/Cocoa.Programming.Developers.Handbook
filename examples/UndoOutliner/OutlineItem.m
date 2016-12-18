#import "OutlineItem.h"


@implementation OutlineItem
@synthesize children;
@synthesize title;

static NSArray *allProperties;
+ (void) initialize
{
	if ([OutlineItem class] != self) { return; }
	allProperties = [[NSArray arrayWithObjects:
					  @"title", nil] retain];
}
- (NSArray*) allProperties
{
	return allProperties;
}
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
- (id) initWithCoder:(NSCoder*)coder
{
    if (nil == (self = [super init]))
	{
		return nil;
    }
	if ([coder allowsKeyedCoding])
	{
		children = [coder decodeObjectForKey:@"children"];
		title = [coder decodeObjectForKey:@"title"];
	}
	else
	{
		children = [coder decodeObject];
		title = [coder decodeObject];
	}
	[children retain];
	[title retain];
	return self;	
}
- (void) encodeWithCoder:(NSCoder*)coder
{
	if ([coder allowsKeyedCoding])
	{
		[coder encodeObject:children forKey:@"children"];
		[coder encodeObject:title forKey:@"title"];	
	}
	else
	{
		[coder encodeObject:children];
		[coder encodeObject:title];
	}
}
- (void) insertObject:(OutlineItem*)item inChildrenAtIndex:(NSUInteger)index
{
	[children insertObject:item atIndex:index];
}
- (void) removeObjectFromChildrenAtIndex:(NSUInteger)index
{
	[children removeObjectAtIndex:index];
}
- (void) dealloc
{
	[children release];
	[title release];
	[super dealloc];
}
@end

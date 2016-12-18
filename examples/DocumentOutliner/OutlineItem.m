#import "OutlineItem.h"

@interface OutlineItemClassDescription : NSClassDescription
@end
@implementation OutlineItemClassDescription
- (NSArray *)attributeKeys
{
	return [NSArray arrayWithObject:@"title"];
}
@end

@implementation OutlineItem
@synthesize children;
@synthesize title;
- (NSClassDescription *)classDescription
{
	return [[[OutlineItemClassDescription alloc] init] autorelease];
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
- (void) dealloc
{
	[children release];
	[title release];
	[super dealloc];
}
@end

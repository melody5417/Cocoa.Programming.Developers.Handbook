#import "OutlineItem.h"


@implementation OutlineItem
@synthesize children;
- (NSArray*) allProperties
{
	return [values allKeys];
}
- (id)init
{
    if (nil == (self = [super init]))
	{
		return nil;
    }
	children = [NSMutableArray new];
	values = [NSMutableDictionary new];
	return self;
}
- (void) setValue: (id)aValue forUndefinedKey: (id)aKey
{
	[values setValue: aValue forKey: aKey];
}
- (id)valueForUndefinedKey: (NSString *)key
{
	return [values valueForKey: key];
}
- (id) initWithCoder: (NSCoder*)coder
{
    if (nil == (self = [super init]))
	{
		return nil;
    }
	if ([coder allowsKeyedCoding])
	{
		children = [coder decodeObjectForKey: @"children"];
		values = [coder decodeObjectForKey: @"values"];
		if (values == nil)
		{
			values = [NSMutableDictionary dictionary];
			[values setObject: [coder decodeObjectForKey:@"title"]
					   forKey: @"title"];
		}
	}
	else
	{
		children = [coder decodeObject];
		values = [coder decodeObject];
	}
	[children retain];
	[values retain];
	return self;	
}
- (void) encodeWithCoder:(NSCoder*)coder
{
	if ([coder allowsKeyedCoding])
	{
		[coder encodeObject: children forKey:@"children"];
		[coder encodeObject: values forKey:@"values"];	
	}
	else
	{
		[coder encodeObject: children];
		[coder encodeObject: values];
	}
}
- (void) insertObject: (OutlineItem*)item inChildrenAtIndex: (NSUInteger)index
{
	[children insertObject: item atIndex: index];
}
- (void) removeObjectFromChildren: (OutlineItem*)child;
{
	[children removeObjectIdenticalTo: child];
}
- (void) dealloc
{
	[children release];
	[values release];
	[super dealloc];
}
@end

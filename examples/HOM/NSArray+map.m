#import "NSArray+map.h"

@interface NSArrayMapProxy : NSProxy {
	NSArray * array;
}
- (id) initWithArray:(NSArray*)anArray;
@end

@implementation NSArrayMapProxy
- (id) initWithArray:(NSArray*)anArray
{
	if (nil == (self = [self init])) { return nil; }
	array = [anArray retain];
	return self;
}
- (id) methodSignatureForSelector:(SEL)aSelector
{
	for (object in array)
	{
		if([object respondsToSelector:aSelector])
		{
			return [object methodSignatureForSelector:aSelector];
		}
	}
	return [super methodSignatureForSelector:aSelector];
}
- (void) forwardInvocation:(NSInvocation*)anInvocation
{
	SEL selector = [anInvocation selector];
	NSMutableArray * mappedArray = 
		[NSMutableArray arrayWithCapacity:[array count]];
	for (object in array)
	{
		if([object respondsToSelector:selector])
		{
			[anInvocation invokeWithTarget:object];
			id mapped;
			[anInvocation getReturnValue:&mapped];
			[mappedArray addObject:mapped];
		}
	}
	[anInvocation setReturnValue:mappedArray];
}
- (void) dealloc
{
	[array release];
	[super dealloc];
}
@end

@implementation NSArray (AllElements)
- (id) map
{
	return [[[NSArrayMapProxy alloc] initWithArray:self] autorelease];
}
@end

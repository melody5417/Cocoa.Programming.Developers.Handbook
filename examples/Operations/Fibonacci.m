#import "Fibonacci.h"

@implementation Fibonacci
- (id) initWithStart:(NSUInteger)i
{
	if (nil == (self = [super init])) { return nil; }
	start = i;
	return self;
}
- (void)main
{
	@try 
	{
		start = [self fibonacci: start];
	}
	@catch (id exception) {}
}
- (NSUInteger) result
{
	if (![self isCancelled] && [self isFinished])
	{
		return start;
	}
	return 0;
}
- (NSUInteger) fibonacci: (NSUInteger)i
{
	if ([self isCancelled])
	{
		[NSException raise: NSGenericException
					format: @"Operation cancelled"];
	}
	switch (i)
	{
		case 0:
		case 1:
			return 1;
		default:
			return [self fibonacci:i-1] 
				 + [self fibonacci:i-2];
	}
}
@end

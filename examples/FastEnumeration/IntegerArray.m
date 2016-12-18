#import "IntegerArray.h"

@implementation IntegerArray
- (id)initWithValues: (NSInteger*)array count: (NSUInteger)size
{
	if (nil == (self = [self init])) { return nil; }
	count = size;
	NSInteger arraySize = size * sizeof(NSInteger);
	values = malloc(arraySize);
	memcpy(values, array, arraySize);
	return self;
}
- (NSInteger)integerAtIndex: (NSUInteger)index
{
	if (index >= count)
	{
		[NSException raise: NSRangeException
		            format: @"Invalid index"];
	}
	return values[index];
}
- (NSUInteger)countByEnumeratingWithState: (NSFastEnumerationState*)state
                                  objects: (id*)stackbuf
                                    count: (NSUInteger)len
{
	NSUInteger n = count - state->state;
	state->mutationsPtr = (unsigned long *)self;
	state->itemsPtr = (id*)(values + state->state);
	state->state += n;
	return n;
}
- (void)dealloc
{
	free(values);
	[super dealloc];
}
@end

@implementation MutableIntegerArray
- (void)setInteger: (NSInteger)newValue atIndex: (NSUInteger)index
{
	version++;
	if (index >= count)
	{
		values = realloc(values, (index+1) * sizeof(NSInteger));
		count = index + 1;
	}
	values[index] = newValue;
}
- (NSUInteger)countByEnumeratingWithState: (NSFastEnumerationState*)state
                                  objects: (id*)stackbuf
                                    count: (NSUInteger)len
{
	NSInteger n;
	state->mutationsPtr = &version;
	n = MIN(len, count - state->state);
	if (n >= 0)
	{
		memcpy(stackbuf, values + state->state, n * sizeof(NSInteger));
		state->state += n;
	}
	else
	{
		n = 0;
	}
	state->itemsPtr = stackbuf;
	return n;
}
@end

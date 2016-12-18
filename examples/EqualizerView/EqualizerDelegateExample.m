#import "EqualizerDelegateExample.h"

@class EqualizerView;

@implementation EqualizerDelegateExample
- (id) init
{
	if (nil == (self = [super init]))
	{
		return nil;
	}
	for (unsigned i=0 ; i<10 ; i++)
	{
		values[i] = (double)i / 10;
	}
	return self;
}
- (NSUInteger) numberOfRowsInEqualizerView:(EqualizerView*)equalizer
{
	return 10;
}
- (double) equalizerView:(EqualizerView*)equalizer
				  valueAtRow:(NSUInteger)aRow
{
	return values[aRow];
}
- (void) equalizerView:(EqualizerView*)equalizer
			  setValue:(double)aValue
				 atRow:(NSUInteger)aRow
{
	values[aRow] = aValue;
}
@end

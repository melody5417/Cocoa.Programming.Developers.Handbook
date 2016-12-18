#import "Fibonacci.h"

@implementation Fibonacci
- (NSUInteger) fibonacci: (NSUInteger)i
{
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

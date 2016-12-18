#import "Pair.h"

@interface IntPair : Pair {
	int first;
	int second;
}
@end
@interface FloatPair : Pair {
	float first;
	float second;
}
@end

@implementation Pair
- (Pair*) initWithFloat: (float)a float: (float)b
{
	[self release];
	return [[FloatPair alloc] initWithFloat: a float: b];
}
- (Pair*) initWithInt: (int)a int: (int)b
{
	[self release];
	return [[IntPair alloc] initWithInt: a int: b];
}
- (float) firstFloat { return 0; }
- (float) secondFloat { return 0; }
- (int) firstInt { return 0; }
- (int) secondInt { return 0; }
@end

@implementation IntPair
- (Pair*) initWithInt: (int)a int: (int)b
{
	first = a;
	second = b;
	return self;
}
- (NSString*) description
{
	return [NSString stringWithFormat: @"(%d, %d)",
		   first, second];
}
- (float) firstFloat { return (float)first; }
- (float) secondFloat { return (float)second; }
- (int) firstInt { return first; }
- (int) secondInt { return second; }
@end
@implementation FloatPair
- (Pair*) initWithFloat: (float)a float: (float)b
{
	first = a;
	second = b;
	return self;
}
- (NSString*) description
{
	return [NSString stringWithFormat: @"(%f, %f)",
		   (double)first, (double)second];
}
- (float) firstFloat { return first; }
- (float) secondFloat { return second; }
- (int) firstInt { return (int)first; }
- (int) secondInt { return (int)second; }
@end

#import "Pair.h"

int main(void)
{
	[NSAutoreleasePool new];
	Pair *floats = [[Pair alloc] initWithFloat:0.5 float:12.42];
	Pair *ints= [[Pair alloc] initWithInt:1984 int:2001];
	NSLog(@"Two floats: %@", floats);
	NSLog(@"Two ints: %@", ints);
	return 0;
}

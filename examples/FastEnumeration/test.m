#import "IntegerArray.h"

int main(void)
{
	[NSAutoreleasePool new];
	NSInteger cArray[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20};
	IntegerArray *array = [[IntegerArray alloc] initWithValues: cArray
														 count: 20];
	NSInteger total = 0;
	for (id i in array)
	{
		total += (NSInteger)i;
	}
	printf("total: %d\n", (int)total);
	MutableIntegerArray *mutablearray = 
		[[MutableIntegerArray alloc] initWithValues: cArray
		                                      count: 20];
	[mutablearray setInteger: 21 atIndex: 20];
	for (id i in mutablearray)
	{
		total += (NSInteger)i;
	}
	printf("total: %d\n", (int)total);
	for (id i in mutablearray)
	{
		total += (NSInteger)i;
		printf("value: %d\n", (int)(NSInteger)i);
		[mutablearray setInteger: 22 atIndex: 21];
	}
	return 0;
}

#import <Foundation/Foundation.h>

@interface NSString (printing)
- (void) print;
@end
@implementation NSString (printing)
- (void) print
{
	fprintf(stderr, "%s\n", [self UTF8String]);
}
@end

int main(void)
{
	[NSAutoreleasePool new];
	NSArray* a = 
		[NSArray arrayWithObjects: @"this", @"is", @"an", @"array", nil];

	NSLog(@"The Objective-C 1 way:");
	NSEnumerator *e=[a objectEnumerator];
	for (id obj=[e nextObject]; nil!=obj ; obj=[e nextObject])
	{
		[obj print];
	}
	NSLog(@"The Leopard way:");
	for (id obj in a)
	{
		[obj print];
	}
	NSLog(@"The simplest way:");
	[a makeObjectsPerformSelector: @selector(print)];
	return 0;
}

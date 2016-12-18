#import <Foundation/Foundation.h>

int main(void)
{
	[NSAutoreleasePool new];
	NSArray *a = [NSArray arrayWithObjects:@"this", @"is", @"an", @"array", nil];
	[a writeToFile:@"array.plist" atomically:NO];
	NSArray *b = [NSArray arrayWithContentsOfFile:@"array.plist"];
	NSLog(@"a: %@", a);
	NSLog(@"b: %@", b);
	return 0;
}

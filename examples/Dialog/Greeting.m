#import "Greeting.h"

@implementation Greeting
- (void)awakeFromNib
{
	dialog = [Dialog new];
	NSArray *replies = 
		[NSArray arrayWithObjects: @"Hello", @"Goodbye", nil];
	[dialog sayString: @"Hello"
			listenFor: replies
			 delegate: self];
}
- (void)dealloc
{
	[dialog release];
	[super dealloc];
}
- (void)speechCommandHello
{
	[dialog sayString: @"Welcome"];
}
- (void)speechCommandGoodbye
{
	[dialog sayString: @"Goodbye"];
	[NSApp terminate: self];
}
@end

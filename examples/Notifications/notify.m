#import <Foundation/Foundation.h>

@interface Receiver : NSObject {}
- (void) receiveNotification: (NSNotification*)aNotification;
@end

@implementation Receiver
- (id) init
{
	if (nil == (self = [super init]))
	{
		return nil;
	}
	// register to receive notifications
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(receiveNotification:)
	               name: @"ExampleNotification"
	             object: nil];
	return self;
}
- (void) receiveNotification: (NSNotification*)aNotification
{
	printf("Received notification: %s\n", 
			[[aNotification name] UTF8String]);
	printf("Received notification: %s\n", 
		[[[aNotification userInfo] objectForKey: @"message"] UTF8String]);
}
- (void) dealloc
{
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center removeObserver: self];
	[super dealloc];
}
@end

@interface Sender : NSObject {}
- (void) sendMessage: (NSString*)aMessage;
@end
@implementation Sender
- (void) sendMessage: (NSString*)aMessage
{
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];

	NSDictionary *message =
		[NSDictionary dictionaryWithObject: aMessage
		                            forKey: @"message"];
	[center postNotificationName: @"ExampleNotification"
	                      object: self
	                    userInfo: message];
}
@end

int main(void)
{
	[NSAutoreleasePool new];
	// Set up the receiver
	Receiver *receiver = [Receiver new];
	// Send the notification
	[[Sender new] sendMessage: @"A short message"];
	return 0;
}

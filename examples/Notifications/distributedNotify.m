#import <Foundation/Foundation.h>

NSString *ChatMessageNotification = 
	@"ChatMessageNotification";
NSString *LineInputNotification = 
	@"LineInputNotification";


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
		[NSDistributedNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(receiveNotification:)
	               name: ChatMessageNotification
	             object: nil];
	return self;
}
- (void) receiveNotification: (NSNotification*)aNotification
{
	printf("%s: %s\n", 
		[[aNotification object] UTF8String],
		[[[aNotification userInfo] objectForKey: @"message"] UTF8String]);
}
- (void) dealloc
{
	NSNotificationCenter *center = 
		[NSDistributedNotificationCenter defaultCenter];
	[center removeObserver: self];
	[super dealloc];
}
@end

@interface Sender : NSObject {
	NSString *name;
}
- (id) initWithName: (NSString*)aName;
@end
@implementation Sender
- (id) initWithName: (NSString*)aName
{
	if (nil == (self = [self init]))
	{
		return nil;
	}
	name = [aName retain];
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(sendMessage:)
	               name: LineInputNotification
	             object: nil];
	return self;
}
- (void) sendMessage: (NSNotification*)aNotificaton
{
	NSNotificationCenter *center = 
		[NSDistributedNotificationCenter defaultCenter];
	NSString *line = 
		[[aNotificaton userInfo] objectForKey: @"Line"];
	NSDictionary *message =
		[NSDictionary dictionaryWithObject: line
									forKey: @"message"];
	[center postNotificationName: ChatMessageNotification
						  object: name
						userInfo: message];
}
- (void) dealloc
{
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center removeObserver: self];
	[name release];
	[super dealloc];
}
@end

@interface LineBuffer : NSObject {
	NSMutableString *buffer;
}
- (id) initWithFile: (NSFileHandle*)aFileHandle;
@end
@implementation LineBuffer
- (id) initWithFile: (NSFileHandle*)aFileHandle
{
	if (nil == (self = [self init]))
	{
		return nil;
	}
	buffer = [[NSMutableString alloc] init];
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(readData:)
	               name: NSFileHandleDataAvailableNotification
	             object: aFileHandle];
	[aFileHandle waitForDataInBackgroundAndNotify];
	return self;
}
- (void) readData: (NSNotification*)aNotification
{
	NSFileHandle *handle = [aNotification object];
	NSData *data = [handle availableData];
	NSString *str = 
		[[NSString alloc] initWithData: data
	                          encoding: NSUTF8StringEncoding];
	[buffer appendString: str];
	[str release];
	NSArray *lines =
	   	[buffer componentsSeparatedByString: @"\n"];
	NSNotificationCenter *center =
	   	[NSNotificationCenter defaultCenter];
	// The last object in the array will be the newline string
	// if a new line is found, or the unterminated line
	for (unsigned int i=0 ; i<[lines count] - 1 ; i++)
	{
		NSDictionary *line =
			[NSDictionary dictionaryWithObject: [lines objectAtIndex: i]
			                            forKey: @"Line"];
		[center postNotificationName: LineInputNotification
							  object: self
							userInfo: line];
	}
	[buffer setString: [lines lastObject]];
	[handle waitForDataInBackgroundAndNotify];
}
- (void) dealloc
{
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center removeObserver: self];
	[buffer release];
	[super dealloc];
}
@end

int main(void)
{
	[NSAutoreleasePool new];
	// Set up the receiver
	Receiver *receiver = [Receiver new];
	NSString *name = 
		[[NSUserDefaults standardUserDefaults]
			stringForKey: @"name"];
	if (nil == name)
	{
		name = @"anon";
	}
	[[Sender alloc] initWithName: name];
	[[LineBuffer alloc] initWithFile:
		[NSFileHandle fileHandleWithStandardInput]];
	[[NSRunLoop currentRunLoop] run];
	return 0;
}

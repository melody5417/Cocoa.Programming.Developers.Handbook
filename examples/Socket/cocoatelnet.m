#import "NSFileHandle+Socket.h"

@interface Telnet : NSObject {
	NSFileHandle *network;
	NSFileHandle *input;
	NSFileHandle *output;
}
- (id) initWithServer: (NSString*)server service: (NSString*)service;
@end

@implementation Telnet
- (id) initWithServer: (NSString*)server service: (NSString*)service
{
	if (nil == (self = [self init])) { return nil; }
	network = [NSFileHandle fileHandleConnectedToRemoteHost: server
												 forService: service];
	if (nil == network)
	{
		[self release];
		return nil;
	}
	input = [NSFileHandle fileHandleWithStandardInput];
	output = [NSFileHandle fileHandleWithStandardOutput];
	
	[network retain]; [input retain]; [output retain];

	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center addObserver:self
			   selector:@selector(printData:)
	               name:NSFileHandleDataAvailableNotification
	             object:network];
	[center addObserver:self
			   selector:@selector(sendData:)
	               name:NSFileHandleDataAvailableNotification
	             object:input];

	[network waitForDataInBackgroundAndNotify];
	[input waitForDataInBackgroundAndNotify];

	return self;
}
- (void) printData:(NSNotification*)notification
{
	[output writeData:[network availableData]];
	[network waitForDataInBackgroundAndNotify];
}
- (void) sendData:(NSNotification*)notification
{
	[network writeData:[input availableData]];
	[input waitForDataInBackgroundAndNotify];
}
- (void) dealloc
{
	[network release];
	[input release];
	[output release];

	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center removeObserver:self];

	[super dealloc];
}
@end

int main(int argc, char **argv)
{
	[NSAutoreleasePool new];
	if (argc != 3)
	{
		fprintf(stderr, "\tUsage: %s {server} {service}\n", argv[0]);
		return 1;
	}
	NSString *server = [NSString stringWithUTF8String:argv[1]];
	NSString *service = [NSString stringWithUTF8String:argv[2]];

	[[Telnet alloc] initWithServer: server service: service];

	[[NSRunLoop currentRunLoop] run];
	return 0;
}

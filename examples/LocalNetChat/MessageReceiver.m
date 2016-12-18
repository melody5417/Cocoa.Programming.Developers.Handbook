#import "MessageReceiver.h"

@implementation MessageReceiver
- (void) awakeFromNib
{
	messages = [[NSMutableArray alloc] init];
	name = [NSFullUserName() retain];
	NSString *servicename = 
		[@"LocalNetChat/" stringByAppendingString:name];
	
	NSPort *port = [[NSSocketPort alloc] init];
	NSConnection *conn = [NSConnection connectionWithReceivePort:port
														sendPort:nil];
	[conn retain];
	[conn setRootObject:self];
	[conn registerName: servicename
		withNameServer: [NSSocketPortNameServer sharedInstance]];
	[port release];
	
	NSNetService *service =
		[[NSNetService alloc] initWithDomain:@""
										type:@"_localchat._tcp."
										name:servicename
										port:123];
	[service publish];
}
- (void) handleMessage:(NSString*)aMessage
				  from:(NSString*)aUser
{
	NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:
		aMessage, @"message",
		aUser, @"sender",
		nil];
	[self willChangeValueForKey:@"messages"];
	[messages addObject:message];
	[self didChangeValueForKey:@"messages"];
}
- (NSString*) name
{
	return name;
}
@end

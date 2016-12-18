#import "MessageSender.h"
#import "ChatPeerProtocol.h"

@implementation MessageSender
- (void) awakeFromNib
{
	peers = [NSMutableArray new];

	NSNetServiceBrowser *serviceBrowser;
	serviceBrowser = [[NSNetServiceBrowser alloc] init];
	[serviceBrowser setDelegate:self];
	[serviceBrowser searchForServicesOfType:@"_localchat._tcp."
								   inDomain:@""];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser
		   didFindService:(NSNetService *)netService 
			   moreComing:(BOOL)moreServicesComing
{
	[netService setDelegate:self];
	[netService retain];
	[netService resolveWithTimeout:10];
	
}
- (void)netServiceDidResolveAddress: (NSNetService *)netService
{
	NSString *host = [netService hostName];
	NSString *servicename = [netService name];
	
	NSSocketPortNameServer *nameserver = 
		[NSSocketPortNameServer sharedInstance]
	id peer = [NSConnection 
		rootProxyForConnectionWithRegisteredName: servicename
											host: host
								 usingNameServer: nameserver];

	if (nil != peer)
	{
		[peer setProtocolForProxy:@protocol(ChatPeerProtocol)];
		[self willChangeValueForKey:@"peers"];
		[peers addObject:[NSDictionary dictionaryWithObjectsAndKeys:
			peer, @"peer",
			[peer name], @"name",
			nil]];
		[self didChangeValueForKey:@"peers"];
		[[peer connectionForProxy] setReplyTimeout:5];
	}
	[netService release];
}
- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
	NSLog(@"Resolving failed: %@", errorDict);
	[sender release];
}
- (IBAction) sendMessage:(id)sender
{
	NSString *message = [sender stringValue];
	if ([@"" isEqualToString: message])	{ return; }
	[sender setStringValue:@""];
	
	NSMutableIndexSet *failedPeers = [NSMutableIndexSet indexSet];
	for (unsigned int i=0 ; i<[peers count] ; i++)
	{
		NSDictionary *dict = [peers objectAtIndex:i];
		id<ChatPeerProtocol> peer = [dict objectForKey:@"peer"];
		@try
		{
			[peer handleMessage:message from:NSFullUserName()];
		}
		@catch (NSException *e)
		{
			[failedPeers addIndex:i];
		}
	}
	if ([failedPeers count] > 0)
	{
		[self willChangeValueForKey:@"peers"];
		[peers removeObjectsAtIndexes:failedPeers];
		[self didChangeValueForKey:@"peers"];
	}
}
@end

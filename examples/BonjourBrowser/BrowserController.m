#import "BrowserController.h"

@implementation BrowserController
- (IBAction) searchForService:(id)sender
{
	NSNetServiceBrowser *serviceBrowser;
	serviceBrowser = [[NSNetServiceBrowser alloc] init];
	[serviceBrowser setDelegate:self];
	[serviceBrowser searchForServicesOfType:[service stringValue]
								   inDomain:@""];
	[service setEnabled:NO];
	[indicator startAnimation:self];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser
		   didFindService:(NSNetService *)netService 
			   moreComing:(BOOL)moreServicesComing

{
	[self willChangeValueForKey:@"services"];
	[services addObject:[netService name]];
	[self didChangeValueForKey:@"services"];
	if (!moreServicesComing)
	{
		[service setEnabled:YES];
		[indicator stopAnimation:self];
		[netServiceBrowser release];
	}
}
- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)netServiceBrowser
{
	[self willChangeValueForKey:@"services"];
	if (nil == services)
	{
		services = [NSMutableArray new];
	}
	else
	{
		[services removeAllObjects];
	}
	[self didChangeValueForKey:@"services"];
}
- (void) dealloc
{
	[services release];
	[super dealloc];
}
@end

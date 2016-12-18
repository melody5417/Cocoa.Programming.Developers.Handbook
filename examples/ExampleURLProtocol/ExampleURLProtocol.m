#import "ExampleURLProtocol.h"

static NSMutableDictionary *urls;

@implementation ExampleURLProtocol
+ (void)load
{
	[self registerClass:self];
}
+ (void)initialize
{
	urls = [[NSMutableDictionary alloc] init];
}
+ (BOOL)canInitWithRequest: (NSURLRequest*)request
{
	NSURL *url = [request URL];
	return [[url scheme] isEqualToString:@"example"];
}
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
	return [NSURLRequest requestWithURL: [request URL]];
}
- (void)startLoading
{
	NSURL *url = [[self request] URL];
	NSString *key = [url absoluteString];
	NSData * data = [[urls objectForKey: key] 
					  dataUsingEncoding: NSUTF8StringEncoding];

	id<NSURLProtocolClient> client = [self client];
	NSURLResponse *response = [[NSURLResponse alloc]
	          initWithURL: url 
	             MIMEType: @"text/plain"
	expectedContentLength: [data length]
	     textEncodingName: @"utf-8"];

	[client URLProtocol: self
	 didReceiveResponse: response
	 cacheStoragePolicy: NSURLCacheStorageNotAllowed];

	[client URLProtocol: self didLoadData: data];

	[client URLProtocolDidFinishLoading: self];
}
- (void)stopLoading { /* Not implemented */ }
+ (BOOL) setString: (NSString*)aString forURL: (NSURL*)aURL
{
	if (![[aURL scheme] isEqualToString:@"example"])
	{
		return NO;
	}
	[urls setObject: aString
			 forKey: [aURL absoluteString]];
}
@end

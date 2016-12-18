#import "MyDocument.h"

@implementation MyDocument
- (NSString *)windowNibName
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib: (NSWindowController*)aController
{
    [super windowControllerDidLoadNib: aController];
	[[view mainFrame] loadHTMLString: loadedDoc
							 baseURL: nil];
	[view setEditable: YES];
	[loadedDoc release];
	loadedDoc = nil;
}

- (NSData *)dataOfType: (NSString*)typeName 
				 error: (NSError**)outError
{
	NSString *doc = 
		[(id)[[[view mainFrame] DOMDocument] documentElement] outerHTML];
	return [doc dataUsingEncoding: NSUTF8StringEncoding];
}

- (BOOL)readFromData: (NSData*)data 
			  ofType: (NSString*)typeName 
			   error: (NSError**)outError
{
	loadedDoc = [[NSString alloc] initWithData: data
										  encoding: NSUTF8StringEncoding];
    return YES;
}

@end

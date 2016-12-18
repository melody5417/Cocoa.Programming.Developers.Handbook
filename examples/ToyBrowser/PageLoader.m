#import "PageLoader.h"

@implementation PageLoader
- (IBAction)loadPage: (id)sender
{
	NSURL *url = [NSURL URLWithString: [sender stringValue]];
	NSData *html = [NSData dataWithContentsOfURL: url];
	NSAttributedString *page =
		[[NSAttributedString alloc] initWithHTML: html
										 baseURL: [url baseURL]
							  documentAttributes: nil];
	[[view textStorage] setAttributedString: page];
}
@end

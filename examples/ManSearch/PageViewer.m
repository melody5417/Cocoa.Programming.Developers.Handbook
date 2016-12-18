#import "PageViewer.h"
#import "ManPage.h"

@implementation PageViewer
- (void)awakeFromNib
{
	[view setString:@""];
	[view setFont: [NSFont fontWithName: @"Monaco" size: 12]];
	[pages addObserver: self
			forKeyPath: @"selection"
			   options: NSKeyValueObservingOptionNew
			   context: NULL];
}
- (void)observeValueForKeyPath: (NSString*)keyPath
					  ofObject: (id)object
                        change: (NSDictionary*)change
                       context: (void*)context
{
	if ([pages selectionIndex] == NSNotFound) { return; }
	NSURL *selectedURL = [[pages selection] valueForKey: @"URL"];
	ManPage *page = [ManPage manPageWithPath: [selectedURL path]];
	[view setString: [page stringValue]];
}
@end

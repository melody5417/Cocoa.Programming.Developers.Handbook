#import <Cocoa/Cocoa.h>

@interface BrowserController : NSObject {
	NSMutableArray *services;
	IBOutlet NSTextField *service;
	IBOutlet NSProgressIndicator *indicator;
}
- (IBAction) searchForService:(id)sender;
@end

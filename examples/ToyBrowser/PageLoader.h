#import <Cocoa/Cocoa.h>

@interface PageLoader : NSObject {
	IBOutlet NSTextView *view;
}
- (IBAction)loadPage: (id)sender;
@end

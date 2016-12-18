#import <Cocoa/Cocoa.h>

@interface Delegate : NSObject {
	NSArray *images;
	IBOutlet NSTableView *view;
}
- (IBAction) openImages: (id) sender;
@end

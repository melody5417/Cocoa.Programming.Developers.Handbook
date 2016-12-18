#import <Cocoa/Cocoa.h>

@interface ReparentView : NSObject {
	IBOutlet NSSplitView *splitView;
}
- (IBAction) reattachView: (id)sender;
- (IBAction) detachView: (id)sender;
@end

#import <Cocoa/Cocoa.h>

@interface TabDetacher : NSObject {
	IBOutlet NSTabView *tabview;
}
- (IBAction)detachTab: (id)sender;
- (IBAction)reattachTab: (id)sender;
@end

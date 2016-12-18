#import <Cocoa/Cocoa.h>

@interface ButtonAnimator : NSObject {
	IBOutlet NSButton *button;
}
- (IBAction)hideButton: (id)sender;
@end

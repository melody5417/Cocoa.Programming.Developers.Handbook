#import <Cocoa/Cocoa.h>

@interface WheelController : NSObject {
	IBOutlet NSTextView *view;
}
- (IBAction) toggleLayout:(id)sender;
@end

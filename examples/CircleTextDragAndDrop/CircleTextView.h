#import <Cocoa/Cocoa.h>
@class CircleTextCell;

@interface CircleTextView : NSView {
	CircleTextCell *cell;
}
- (IBAction) takePaddingValueFrom: (id)sender;
@end

#import <Cocoa/Cocoa.h>
@class CompositeView;

@interface Controller : NSObject {
	IBOutlet NSImageView *src;
	IBOutlet NSImageView *dst;
	IBOutlet CompositeView *view;
}
- (IBAction) imageChanged:(id)sender;
@end

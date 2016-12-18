#import <Cocoa/Cocoa.h>

@class CALayer;
@class CATransition;

@interface TransitionController : NSObject {
	IBOutlet NSImageView *view;
	IBOutlet NSImageView *hiddenView;
	CALayer *layer;
	CALayer *hiddenLayer;
	CATransition *transition;
	IBOutlet NSView *windowView;
}
- (IBAction)setTransitionType: (id)sender;
- (IBAction)setTransitionSubtype: (id)sender;
- (IBAction)runTransition: (id)sender;
@end

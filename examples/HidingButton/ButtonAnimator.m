#import "ButtonAnimator.h"
#import <QuartzCore/CoreAnimation.h>

@implementation ButtonAnimator
- (IBAction)hideButton: (id)sender
{
	CALayer *layer = [sender layer];
	CGSize destination = NSSizeToCGSize([[sender superview] bounds].size);
	destination.width *= (((float)random()) / ((float)LONG_MAX));
	destination.height *= (((float)random()) / ((float)LONG_MAX));
	layer.position = *(CGPoint*)&destination;
	NSRect frame = [sender frame];
	frame.origin.x = destination.width;
	frame.origin.y = destination.height;	
	[sender setFrame: frame];
}
@end

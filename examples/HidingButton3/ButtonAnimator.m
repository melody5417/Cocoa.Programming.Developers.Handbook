#import "ButtonAnimator.h"
#import <QuartzCore/QuartzCore.h>

@implementation ButtonAnimator
- (IBAction)hideButton: (id)sender
{
	CGSize destination = NSSizeToCGSize([[sender superview] bounds].size);
	destination.width *= (((float)random()) / ((float)LONG_MAX));
	destination.height *= (((float)random()) / ((float)LONG_MAX));
	[[sender animator] setFrameOrigin: *(NSPoint*)&destination];
	CIFilter *blur = [CIFilter filterWithName: @"CIMotionBlur"];
	[blur setDefaults];
	[sender layer].filters = [NSArray arrayWithObject: blur];
}
@end

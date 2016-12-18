#import "RotateController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CALayer.h>

@implementation RotateController
- (IBAction)runRotate: (id)sender
{
	CALayer *layer = [sender layer];
	CGPoint point = {0.5, 0};
	if (!CGPointEqualToPoint(point, layer.anchorPoint))
	{
		CGFloat displace = layer.frame.size.width / 2;
		CGPoint origin = layer.position;
		origin.x += displace;
		[CATransaction begin];
		[CATransaction setValue: [NSNumber numberWithInt: 0]
						 forKey: kCATransactionAnimationDuration];
		layer.anchorPoint = point;
		layer.position = origin;
		[CATransaction commit];
	}
	NSMutableArray *steps = [NSMutableArray arrayWithObjects:
							 [NSNumber numberWithFloat: 1.0/3.0*M_PI],
							 [NSNumber numberWithFloat: 4.0/3.0*M_PI],
							 [NSNumber numberWithFloat: 2*M_PI],
							 nil];
	CAKeyframeAnimation *animation = 
		[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
	animation.values = steps;
	animation.duration = 5;
	[[sender layer] addAnimation: animation
						  forKey: @"spin"];
}
@end

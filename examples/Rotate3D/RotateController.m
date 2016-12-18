#import "RotateController.h"
#import <QuartzCore/QuartzCore.h>

@implementation RotateController
- (IBAction)runRotate: (id)sender
{
	CAKeyframeAnimation *animation = 
		[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
	animation.values = [NSArray arrayWithObjects:
						[NSNumber numberWithFloat: (60 * M_PI / 180)],
						[NSNumber numberWithFloat: (120 * M_PI / 180)],
						[NSNumber numberWithFloat: (180 * M_PI / 180)],
						[NSNumber numberWithFloat: (240 * M_PI / 180)],
						[NSNumber numberWithFloat: (300 * M_PI / 180)],
						[NSNumber numberWithFloat: (360 * M_PI / 180)],
						nil];
	animation.duration = 5;
	[[sender layer] addAnimation: animation
						  forKey: @"spin"];
}
@end

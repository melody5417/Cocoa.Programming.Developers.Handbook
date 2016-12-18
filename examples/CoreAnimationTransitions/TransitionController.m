#import "TransitionController.h"
#import <QuartzCore/QuartzCore.h>

static NSArray *transitionTypes;
static NSArray *transitionSubtypes;
@implementation TransitionController
+ (void)initialize
{
	transitionTypes = [[NSArray arrayWithObjects: 
		kCATransitionFade,
		kCATransitionMoveIn,
		kCATransitionPush,
		kCATransitionReveal,
		nil] retain];
	transitionSubtypes = [[NSArray arrayWithObjects: 
		kCATransitionFromRight,
		kCATransitionFromLeft,
		kCATransitionFromTop,
		kCATransitionFromBottom,
		nil] retain];
}
- (void)awakeFromNib
{
	layer = [[view layer] retain];
	hiddenLayer = [[hiddenView layer] retain];
	[hiddenLayer removeFromSuperlayer];
	[layer removeFromSuperlayer];
	[[windowView layer] addSublayer: layer];
	transition = [CATransition new];
	transition.type = kCATransitionMoveIn;
	transition.subtype = kCATransitionFromTop;
	transition.duration = 2;
}
- (IBAction)setTransitionType: (id)sender;
{
	transition.type =
		[transitionTypes objectAtIndex: [[sender selectedItem] tag]];
}
- (IBAction)setTransitionSubtype: (id)sender;
{
	transition.subtype = 
		[transitionSubtypes objectAtIndex: [[sender selectedItem] tag]];
}
- (IBAction)runTransition: (id)sender
{
	CALayer *windowLayer = [windowView layer];
	[windowLayer setActions:
		[NSDictionary dictionaryWithObject: transition
									forKey: @"sublayers"]];
	[windowLayer replaceSublayer: layer
							with: hiddenLayer];
	CALayer *tmp = layer;
	layer = hiddenLayer;
	hiddenLayer = tmp;
}
@end

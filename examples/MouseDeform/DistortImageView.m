#import "DistortImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DistortImageView
- (void) awakeFromNib
{
	[[self window] setAcceptsMouseMovedEvents:YES]; 
	[[self window] makeFirstResponder:self];
	[self setWantsLayer: YES];
}
- (BOOL)acceptsFirstResponder { return YES; }
- (void)mouseMoved: (NSEvent*)theEvent
{
	NSPoint mouse = [self convertPoint:[theEvent locationInWindow]
							  fromView:nil];
	CIFilter *distort = [CIFilter filterWithName: @"CIPinchDistortion"];
	[distort setDefaults];
	[distort setValue: [CIVector vectorWithX: mouse.x Y: mouse.y]
			   forKey: @"inputCenter"];
	[self layer].filters = [NSArray arrayWithObject: distort];
}
@end

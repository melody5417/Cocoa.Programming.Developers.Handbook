#import "MouseTrackView.h"

@implementation MouseTrackView
- (void)drawRect: (NSRect)rect
{
	[path stroke];
}
- (void)mouseDown: (NSEvent*)theEvent
{
	NSPoint click = [self convertPoint: [theEvent locationInWindow]
							  fromView: nil];
	if (nil == path)
	{
		path = [NSBezierPath new];
		[path moveToPoint: click];
		[path setLineWidth: 2];
	}
	else
	{
		[path lineToPoint: click];
	}
	[self setNeedsDisplay: YES];
}
- (void) dealloc
{
	[path release];
	[super dealloc];
}
@end

#import "BezierTrack.h"

@implementation BezierTrack
- (void)drawRect: (NSRect)rect
{
	NSBezierPath *control1 = [NSBezierPath bezierPath];
	[control1 moveToPoint: points[0]];
	[control1 lineToPoint: points[1]];
	[[NSColor redColor] setStroke];
	[control1 setLineWidth: 2];
	[control1 stroke];
	NSBezierPath *control2 = [NSBezierPath bezierPath];
	[control2 moveToPoint: points[2]];
	[control2 lineToPoint: points[3]];
	[[NSColor greenColor] setStroke];
	[control2 setLineWidth: 2];
	[control2 stroke];
	NSBezierPath *curve = [NSBezierPath bezierPath];
	[curve moveToPoint: points[0]];
	[curve curveToPoint: points[3]
		  controlPoint1: points[1] 
		  controlPoint2: points[2]];
	[[NSColor grayColor] setFill];
	[[NSColor blackColor] setStroke];
	[curve fill];
	[curve stroke];
}
- (void)mouseDown: (NSEvent *)theEvent
{
	NSPoint click = [self convertPoint: [theEvent locationInWindow]
							  fromView: nil];
	points[pointCount++ % 4] = click;
	if (pointCount % 4 == 0)
	{
		[self setNeedsDisplay: YES];
	}
}
@end

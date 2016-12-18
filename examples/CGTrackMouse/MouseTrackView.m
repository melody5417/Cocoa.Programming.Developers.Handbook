#import "MouseTrackView.h"
#include <Quartz/Quartz.h>

@implementation MouseTrackView
- (void) awakeFromNib
{
	points = [NSMutableArray new];
}
- (void)drawRect:(NSRect)rect
{
	if ([points count] == 0)
	{
		return;
	}
	NSGraphicsContext *context = [NSGraphicsContext currentContext];
	CGContextRef cgContext = [context graphicsPort];
	
	CGContextSetLineWidth(cgContext, 2.0f);
	CGContextSetStrokeColorWithColor(cgContext, 
		CGColorGetConstantColor(kCGColorBlack));
	
	CGContextBeginPath(cgContext);
	CGPoint firstPoint = NSPointToCGPoint([[points objectAtIndex:0] pointValue]);
	CGContextMoveToPoint(cgContext, firstPoint.x, firstPoint.y);
	for (NSValue *point in points)
	{
		CGPoint pt = NSPointToCGPoint([point pointValue]);
		CGContextAddLineToPoint(cgContext, pt.x, pt.y);
	}
	CGContextDrawPath(cgContext,  kCGPathStroke);
}
- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint click = [self convertPoint:[theEvent locationInWindow]
							  fromView:nil];
	[points addObject:[NSValue valueWithPoint:click]];
	[self setNeedsDisplay:YES];
}
- (void) dealloc
{
	[points release];
	[super dealloc];
}
@end

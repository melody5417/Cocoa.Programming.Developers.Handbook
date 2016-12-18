#import "WheelLayout.h"

@implementation WheelLayout
@synthesize holeSize;
- (id) init
{
	if (nil == (self=[super init])) { return nil; }
	holeSize = 50;
	return self;
}

- (NSRect)lineFragmentRectForProposedRect:(NSRect)proposedRect
						   sweepDirection:(NSLineSweepDirection)sweepDirection
						movementDirection:(NSLineMovementDirection)movementDirection
							remainingRect:(NSRectPointer)remainingRect
{
    NSSize containerSize = [self containerSize];
	// First trim the proposed rectangle to the container
    NSRect rect = 
		[super lineFragmentRectForProposedRect:proposedRect
								sweepDirection:sweepDirection
							 movementDirection:movementDirection
								 remainingRect:remainingRect];
	// Now trim it to the rectangle to the width of the circle
	CGFloat radius = fmin(containerSize.width, containerSize.height) / 2.0;
	CGFloat y = fabs((rect.origin.y + rect.size.height / 2.0) - radius);
	CGFloat lineWidth = 2 * sqrt(radius * radius - y * y);

	NSRect circleRect =
		NSMakeRect(rect.origin.x + radius - lineWidth / 2.0,
				   rect.origin.y,
				   lineWidth,
				   rect.size.height);	
	if (y < holeSize)
	{
		CGFloat right = circleRect.origin.x	+ circleRect.size.width;
		circleRect.size.width /= 2;
		CGFloat holeWidth =  sqrt(holeSize * holeSize - y * y);
		circleRect.size.width -= holeWidth;
		if (remainingRect != NULL && circleRect.origin.x < radius)
		{
			*remainingRect = circleRect;
			remainingRect->origin.x = right - circleRect.size.width;
		}
	}
	return circleRect;
}

- (BOOL)isSimpleRectangularTextContainer
{
    return NO;
}
@end

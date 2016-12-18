#import "CircleTextLayer.h"


@implementation CircleTextLayer
- (void) awakeFromNib
{
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSFont fontWithName:@"Zapfino" size:32],
								NSFontAttributeName,
								nil];
	str = [[NSAttributedString alloc]
		   initWithString: @"Hello world! This is a long string."
		       attributes:attributes];
	[[view layer] setDelegate: self];
	NSLog(@"Layer: %@", [view layer]);
	[[view layer] setNeedsDisplay];
}
- (void)drawLayer: (CALayer*)layer inContext: (CGContextRef)ctx
{
	NSGraphicsContext *context = 
		[NSGraphicsContext graphicsContextWithGraphicsPort: ctx
												   flipped: NO];
	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext: context];

	NSAffineTransform *transform = [NSAffineTransform transform];
	[transform translateXBy:150 yBy:10];
	[transform concat];
	
	NSPoint point = {0,0};
	NSUInteger stringLength = [[str string] length];
	const CGFloat extraSpace = 5;
	CGFloat angleScale = 360 / ([str size].width + (extraSpace * stringLength));
	for (NSUInteger i=0 ; i<stringLength ; i++)
	{
		NSAttributedString *substr = 
		[str attributedSubstringFromRange:NSMakeRange(i, 1)];
		[substr drawAtPoint:point];
		
		transform = [NSAffineTransform transform];
		CGFloat displacement = [substr size].width + extraSpace;
		[transform translateXBy:displacement
							yBy:0];
		[transform rotateByDegrees:angleScale * displacement];
		[transform concat];
	}
	
	[NSGraphicsContext restoreGraphicsState];
}
@end

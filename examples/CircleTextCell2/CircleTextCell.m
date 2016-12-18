#import "CircleTextCell.h"

#define PI (3.141592653589793)

@implementation CircleTextCell
- (void) drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSAttributedString *str = [self attributedStringValue];
	NSSize stringSize = [str size];
	NSUInteger chars = [[str string] length];
	CGFloat radius = (stringSize.width + extraPadding * chars) / (2 * PI);
	CGFloat diameter = 2*radius;
	NSPoint scale = {1,1};
	if (diameter > cellFrame.size.width)
	{
		scale.x = cellFrame.size.width / diameter;
	}
	if (diameter > cellFrame.size.height)
	{
		scale.y = cellFrame.size.height / diameter;
	}
	NSAffineTransform * transform = [NSAffineTransform transform];
	NSAffineTransformStruct identity = [transform transformStruct];
	[transform scaleXBy:scale.x yBy:scale.y];
	[transform translateXBy:radius yBy:0];
	[NSGraphicsContext saveGraphicsState];
	[transform concat];
	
	NSPoint origin = {0,0};
	CGFloat angleScale = 360 / ([str size].width + (extraPadding * chars));
	for (NSUInteger i=0 ; i<chars ; i++)
	{
		NSAttributedString *substr = 
			[str attributedSubstringFromRange:NSMakeRange(i, 1)];
		[substr drawAtPoint:origin];
		
		[transform setTransformStruct:identity];
		CGFloat displacement = [substr size].width + extraPadding;
		[transform translateXBy:displacement
							yBy:0];
		[transform rotateByDegrees:angleScale * displacement];
		[transform concat];
	}
	[NSGraphicsContext restoreGraphicsState];
}
- (void) setPadding:(CGFloat) aFloat
{
	extraPadding = aFloat;
}
- (CGFloat) padding
{
	return extraPadding;
}
- (NSSize)cellSize
{
	NSAttributedString *str = [self attributedStringValue];
	NSSize stringSize = [str size];
	NSUInteger chars = [[str string] length];
	CGFloat radius = (stringSize.width + extraPadding * chars) / (2 * PI);
	CGFloat diameter = 2*radius;
	return NSMakeSize(diameter, diameter);
}
@end

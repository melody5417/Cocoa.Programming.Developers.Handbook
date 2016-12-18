#import "CurveTextView.h"


@implementation CurveTextView
- (void)drawRect:(NSRect)rect
{	
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSFont fontWithName:@"Zapfino" size:32],
		NSFontAttributeName,
		nil];
	NSAttributedString *str = 
		[[NSAttributedString alloc] initWithString: @"Hello world!"
										attributes:attributes];

	NSAffineTransform *transform = [NSAffineTransform transform];
	[transform translateXBy:10 yBy:10];
	[transform concat];

	NSPoint point = {0,0};
	for (unsigned i=0 ; i<[[str string] length] ; i++)
	{
		NSAttributedString *substr = 
			[str attributedSubstringFromRange:NSMakeRange(i, 1)];
		[substr drawAtPoint:point];

		transform = [NSAffineTransform transform];
		[transform translateXBy:[substr size].width + 3
							yBy:0];
		[transform rotateByDegrees:6];
		[transform concat];
	}
}
@end

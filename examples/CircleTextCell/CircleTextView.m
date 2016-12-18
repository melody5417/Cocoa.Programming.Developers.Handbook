#import "CircleTextView.h"
#import "CircleTextCell.h"

@implementation CircleTextView
- (void) awakeFromNib
{
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSFont fontWithName:@"Zapfino" size:32],
								NSFontAttributeName,
								nil];
	NSAttributedString *str = 
	[[NSAttributedString alloc] initWithString: @"Hello world! This is a long string which will be wrapped into a circle by a cell."
									attributes:attributes];
	
	cell = [[CircleTextCell alloc] init];
	[cell setAttributedStringValue:str];
	[cell setPadding:5];
}
- (void)drawRect:(NSRect)rect
{
	[[NSColor whiteColor] setFill];
	[NSBezierPath fillRect:rect];
	[cell drawWithFrame:[self bounds]
				 inView:self];
}
@end

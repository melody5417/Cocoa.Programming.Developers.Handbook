#import "FormView.h"

@implementation FormView
- (BOOL)isFlipped
{
	return YES;
}
- (void)addSubview: (NSView*)aView
{
	[super addSubview: aView];

	NSRect frame = [aView frame];
	frame.origin.x = 0;
	frame.origin.y = (CGFloat)top;
	frame.size.width = [self frame].size.width;
	
	[aView setFrame: frame];
	
	top += frame.size.height;
}
- (void)setFrame: (NSRect)aFrame
{
	CGFloat y = 0;
	for (NSView *view in [self subviews])
	{
		NSRect frame = [view frame];
		frame.origin.y = y;
		frame.size.width = aFrame.size.width;
		y += frame.size.height;
		[view setFrame: frame];
	}
	aFrame.size.height = top;
	[super setFrame: aFrame];
}
@end

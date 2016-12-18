#import "RearrangingScrollView.h"

@implementation RearrangingScrollView
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
	
	[aView setFrame: frame];
	
	top += frame.size.height;
}
- (void)willRemoveSubview: (NSView*)subview
{
	top -= [subview frame].size.height;
	CGFloat y = 0;
	for (NSView *view in [self subviews])
	{
		if (view != subview)
		{
			NSRect frame = [view frame];
			frame.origin.y = y;
			y += frame.size.height;
			[view setFrame: frame];
		}
	}
}
- (void)setFrame: (NSRect)aFrame
{
	CGFloat y = 0;
	CGFloat width = aFrame.size.width;
	for (NSView *view in [self subviews])
	{
		NSRect frame = [view frame];
		frame.origin.y = y;
		y += frame.size.height;
		width = MAX(width, frame.size.width);
		[view setFrame: frame];
	}
	aFrame.size.height = top;
	aFrame.size.width = width;
	[super setFrame: aFrame];
}
@end

#import "BouncingWindowController.h"

@implementation BouncingWindowController
- (void)awakeFromNib
{
	[NSTimer scheduledTimerWithTimeInterval: 0.01
									 target: self
								   selector: @selector(animate:)
								   userInfo: nil
									repeats: YES];
	dy = 1;
	dx = 1;
}
- (void)animate: (id)sender
{
	NSWindow *w = [self window];
	NSRect frame = [w frame];
	NSRect screen = [[w screen] visibleFrame];
	frame.origin.x += dx;
	frame.origin.y += dy;
	if (frame.origin.x + frame.size.width >= (screen.size.width + screen.origin.x)
		||
		frame.origin.x < screen.origin.x)
	{
		dx = -dx;
	}		
	if (frame.origin.y + frame.size.height >= (screen.size.height + screen.origin.y)
		||
		frame.origin.y < screen.origin.y)
	{
		dy = -dy;
	}
	[w setFrame: frame
		display: NO
		animate: NO];
}
@end

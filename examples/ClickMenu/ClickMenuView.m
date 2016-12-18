#import "ClickMenuView.h"


@implementation ClickMenuView
- (void)awakeFromNib
{
	cell = [NSPopUpButtonCell new];
}
- (void)mouseDown: (NSEvent*)theEvent
{
	NSRect frame;
	frame.origin = [self convertPoint: [theEvent locationInWindow]
							 fromView: nil];
	frame.size = NSZeroSize;
	
	[cell setMenu: clickMenu];
	[cell performClickWithFrame: frame
	                     inView: self];
}
@end

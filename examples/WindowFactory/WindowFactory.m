#import "WindowFactory.h"

@implementation WindowFactory
- (IBAction)createWindowFromNib: (id)sender
{
	// Note: This leaks.
	NSWindowController *controller =
		[[NSWindowController alloc] initWithWindowNibName: @"Window"];
	[controller showWindow: self];
}
- (IBAction)createWindowInCode: (id)sender
{
	NSUInteger style = NSClosableWindowMask;
	if ([isTitled state] == NSOnState)
	{
		style |= NSTitledWindowMask;
	}
	if ([isTextured state] == NSOnState)
	{
		style |= NSTexturedBackgroundWindowMask;
	}
	NSRect frame = [[sender window] frame];
	frame.origin.x += (((double)random()) / LONG_MAX) * 200;
	frame.origin.y += (((double)random()) / LONG_MAX) * 200;
	NSWindow *win = 
		[[NSWindow alloc] initWithContentRect: frame
									styleMask: style
									  backing: NSBackingStoreBuffered
										defer: NO];
	if ([isOpaque state] == NSOffState)
	{
		[win setOpaque: NO];
		[win setAlphaValue: 0.5];
	}
	[win setHasShadow: ([hasShadow state] == NSOnState)];
	
	[win setTitle: [title stringValue]];
	[win orderFront: self];
}
@end

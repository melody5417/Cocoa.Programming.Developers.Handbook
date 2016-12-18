#import "TabDetacher.h"

@implementation TabDetacher
- (IBAction)detachTab: (id)sender
{
	NSView *view = [sender superview];
	
	NSTabViewItem *containingItem = nil;
	for (NSTabViewItem *item in [tabview tabViewItems])
	{
		if ([item view] == view)
		{
			containingItem = item;
		}
	}

	NSRect frame = [view frame];
	frame.origin = 
		[[[view window] contentView] convertPoint: frame.origin
										 fromView: [view superview]];
	frame.origin = [[view window] convertBaseToScreen: frame.origin];
	
	[tabview removeTabViewItem: containingItem];
	
	NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSUtilityWindowMask;
	NSPanel *panel =
		[[NSPanel alloc] initWithContentRect: frame
								   styleMask: style
									 backing: NSBackingStoreBuffered
									   defer: NO];
	[panel setTitle: [containingItem label]];
	[panel setContentView: view];
	[panel makeKeyAndOrderFront: self];
		
	[sender setAction: @selector(reattachTab:)];
	[sender setTitle: @"Reattach"];
}
- (IBAction)reattachTab: (id)sender
{
	NSView *view = [sender superview];
	NSWindow *window = [view window];
	
	NSTabViewItem *item = [NSTabViewItem new];
	[item setView: view];
	[view removeFromSuperview];
	[item setLabel: [window title]];

	[window performClose: self];
	
	[tabview addTabViewItem: item];
	[tabview selectTabViewItem: item];
	[item release];
	
	[sender setAction: @selector(detachTab:)];
	[sender setTitle: @"Detach"];

}
@end

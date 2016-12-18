#import "ReparentView.h"

@implementation ReparentView
- (IBAction) reattachView: (id)sender
{
	if (![sender isKindOfClass: [NSView class]]) { return; }
	
	NSWindow *win = [sender window];
	[sender retain];
	[sender removeFromSuperview];
	[win performClose: self];
	[win release];
	[splitView addSubview: sender];
	[sender release];
	
	[sender setAction: @selector(detachView:)];
}
- (IBAction) detachView: (id)sender
{
	if (![sender isKindOfClass: [NSView class]]) { return; }
	
	NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSUtilityWindowMask;
	NSPanel *panel = [[NSPanel alloc] initWithContentRect: [sender frame]
												styleMask: style
												  backing: NSBackingStoreBuffered
													defer: NO];
	[sender retain];
	[sender removeFromSuperview];
	[panel setContentView: sender];
	[sender release];

	[sender setAction: @selector(reattachView:)];

	[panel makeKeyAndOrderFront: self];
}
@end

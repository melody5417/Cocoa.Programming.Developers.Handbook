#import "ReparentView.h"

@implementation ReparentView
- (IBAction) reparentView: (id)sender
{
	if (![sender isKindOfClass: [NSView class]]) { return; }
	
	NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSUtilityWindowMask;
	NSPanel *panel = 
		[[NSPanel alloc] initWithContentRect: [sender frame]
								   styleMask: style
								     backing: NSBackingStoreBuffered
									   defer: NO];
	[sender retain];
	[sender removeFromSuperview];
	[panel setContentView: sender];
	[sender release];

	[panel makeKeyAndOrderFront: self];
}
@end

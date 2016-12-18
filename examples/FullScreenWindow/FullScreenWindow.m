#import "FullScreenWindow.h"

@implementation FullScreenWindow
+ (NSWindow*) fullScreenWindowOnScreen: (NSScreen*)screen
						  withContents: (NSView*)contents
{
	NSDictionary* screenInfo = [screen deviceDescription];
	NSNumber* screenID = [screenInfo objectForKey: @"NSScreenNumber"];
	// Capture the display.
	CGDisplayErr err = CGDisplayCapture([screenID longValue]);
	if (err != CGDisplayNoErr)
	{
		return nil;		
	}

	// Create the window
	NSRect winRect = [screen frame];
	NSWindow *newWindow = 
		[[FullScreenWindow alloc] initWithContentRect: winRect
		                                    styleMask: NSBorderlessWindowMask
		                                      backing: NSBackingStoreBuffered
		                                        defer: NO
		                                       screen: screen];
	[newWindow setContentView: contents];

	// Set it to above the shield window.
	int32_t shieldLevel = CGShieldingWindowLevel();
	[newWindow setLevel: shieldLevel];

	[newWindow makeKeyAndOrderFront:self];
	return newWindow;
}
- (BOOL) canBecomeKeyWindow
{
	return YES;
}
@end

#import <Cocoa/Cocoa.h>

@interface FullScreenWindow : NSWindow {}
+ (NSWindow*) fullScreenWindowOnScreen:(NSScreen*)screen
						  withContents:(NSView*)contents;
@end

#import <Cocoa/Cocoa.h>

@interface ClickMenuView : NSView {
	IBOutlet NSMenu *clickMenu;
	NSPopUpButtonCell *cell;
}
@end

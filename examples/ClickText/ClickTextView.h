#import <Cocoa/Cocoa.h>

@interface ClickTextView : NSView {
	NSMutableArray *texts;
	NSPoint currentLocation;
	NSCell *cell;
}
@end

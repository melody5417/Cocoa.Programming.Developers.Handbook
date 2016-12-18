#import <Cocoa/Cocoa.h>

@interface CompositeView : NSView {
	NSImage *src;
	NSImage *dst;
}
- (void) setSrc:(NSImage*)aSource dst:(NSImage*)aDestination;
@end

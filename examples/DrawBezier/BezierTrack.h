#import <Cocoa/Cocoa.h>

@interface BezierTrack : NSView {
	NSPoint points[4];
	int pointCount;
}

@end

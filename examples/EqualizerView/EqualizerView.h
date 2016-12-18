#import <Cocoa/Cocoa.h>


@interface EqualizerView : NSView {
	IBOutlet id datasource;
	NSLevelIndicatorCell *cell;
	NSLevelIndicatorCell *editCell;
	NSUInteger trackingRow;
	NSRect trackingFrame;
}
@end

@interface NSObject (EqualizerDataSource)
- (NSUInteger) numberOfRowsInEqualizerView:(EqualizerView*)equalizer;
- (double) equalizerView:(EqualizerView*)equalizer
			  valueAtRow:(NSUInteger)aRow;
// Optional:
- (void) equalizerView:(EqualizerView*)equalizer
			  setValue:(double)aValue
				 atRow:(NSUInteger)aRow;
@end

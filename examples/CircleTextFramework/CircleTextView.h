#import <Cocoa/Cocoa.h>
@class CircleTextCell;

@interface CircleTextView : NSView <NSCoding>{
	CircleTextCell *cell;
}
- (void) setAttributedStringValue:(NSAttributedString*)aString;
- (NSAttributedString*) attributedStringValue;
- (void) setPadding:(CGFloat)padding;
- (CGFloat) padding;
@end

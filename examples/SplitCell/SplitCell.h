#import <Cocoa/Cocoa.h>

@interface SplitCell : NSCell {
	NSCell *left;
	NSCell *right;
	NSString *leftKey;
	NSString *rightKey;
	CGFloat split;
}
@property (nonatomic,retain) NSString *leftKey;
@property (nonatomic,retain) NSString *rightKey;
@property CGFloat split;
- (id) initWithLeftCell: (NSCell*)aCell rightCell: (NSCell*)aCell2;
@end

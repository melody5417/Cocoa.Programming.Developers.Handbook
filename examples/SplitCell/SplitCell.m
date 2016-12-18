#import "SplitCell.h"


@implementation SplitCell
@synthesize leftKey;
@synthesize rightKey;
@synthesize split;
- (id) initWithLeftCell: (NSCell*)aCell rightCell: (NSCell*)aCell2
{
	if (nil == (self = [self init])) { return nil; }
	left = [aCell retain];
	right = [aCell2 retain];
	split = 0.5;
	return self;
}
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSRect leftFrame = cellFrame;
	leftFrame.size.width *= split;
	NSRect rightFrame = cellFrame;
	rightFrame.size.width = cellFrame.size.width - leftFrame.size.width;
	rightFrame.origin.x = leftFrame.size.width;
	id obj = [self objectValue];
	if (nil != leftKey)
	{
		[left setObjectValue: [obj valueForKey: leftKey]];
	}
	else
	{
		[left setObjectValue: obj];
	}
	[left drawWithFrame: leftFrame
				 inView: controlView];
	if (nil != rightKey)
	{
		[right setObjectValue: [obj valueForKey: rightKey]];
	}
	else
	{
		[right setObjectValue: obj];
	}
	[right drawWithFrame: rightFrame
				  inView: controlView];
}
@end

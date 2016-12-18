#import "SplitCellDemo.h"
#import "SplitCell.h"

@implementation SplitCellDemo
- (void) awakeFromNib
{
	[self willChangeValueForKey: @"objects"];
	objects = [[NSArray alloc] initWithObjects: 
			   @"12", @"42", @"64",
			   @"25", @"11.5", nil];
	[self didChangeValueForKey: @"objects"];
	NSLevelIndicatorCell *right = [[NSLevelIndicatorCell alloc] init];
	[right setMaxValue: 100];
	[right setLevelIndicatorStyle: NSContinuousCapacityLevelIndicatorStyle];
	NSCell *left = [[NSTextFieldCell alloc] init];
	SplitCell *cell = [[SplitCell alloc] initWithLeftCell: left
												rightCell: right];
	cell.split = 0.2;
	[column setDataCell: cell];
}
@end

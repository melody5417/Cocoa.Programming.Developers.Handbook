#import "WheelController.h"
#import "WheelLayout.h"

@implementation WheelController
- (IBAction) toggleLayout:(id)sender
{
	NSTextContainer *oldContainer = [view textContainer];
	Class newContainerClass;
	if ([oldContainer isKindOfClass:[WheelLayout class]])
	{
		newContainerClass = [NSTextContainer class];
	}
	else
	{
		newContainerClass = [WheelLayout class];
	}
	NSTextContainer *newContainer =	[[newContainerClass alloc] init];
	[newContainer setHeightTracksTextView:YES];
	[newContainer setWidthTracksTextView:YES];
	[view replaceTextContainer:newContainer];
	[newContainer release];
}
@end

#import "Controller.h"
#import "CompositeView.h"

@implementation Controller
- (IBAction) imageChanged:(id)sender
{
	[view setSrc:[src image] dst:[dst image]];
	[view setNeedsDisplay:YES];
}
@end

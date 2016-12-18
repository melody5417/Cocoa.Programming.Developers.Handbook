#import "HelloView.h"


@implementation HelloView
- (void) createCell
{
	cell = [[NSCell alloc] initTextCell:@"Hello World"];
	[cell setFont:[NSFont fontWithName:@"Times"
								  size:32]];
}
- (void) awakeFromNib
{
	[self createCell];
}
- (id)initWithFrame:(NSRect)frame
{
    if (nil != (self = [super initWithFrame:frame]))
	{
		[self createCell];
    }
    return self;
}
- (void)drawRect:(NSRect)rect
{
	[cell drawWithFrame:rect inView:self];
}
@end

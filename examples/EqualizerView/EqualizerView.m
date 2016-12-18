#import "EqualizerView.h"


@implementation EqualizerView
static const double IndicatorBoxes = 10;
- (void) createCells
{
	cell = [[NSLevelIndicatorCell alloc] initWithLevelIndicatorStyle: NSDiscreteCapacityLevelIndicatorStyle];
	[cell setMaxValue:IndicatorBoxes];
	[cell setWarningValue:IndicatorBoxes/2];
	[cell setCriticalValue:IndicatorBoxes/4*3];
	editCell = [cell copy];
	[editCell setEditable:YES];
	[editCell setContinuous:YES];
	[editCell setTarget:self];
	[editCell setAction:@selector(cellValueChanged:)];
}
- (void) awakeFromNib
{
	[self createCells];
}
- (id)initWithFrame:(NSRect)frame
{
    if (nil == (self = [super initWithFrame:frame]))
	{
		return nil;
	}
	[self createCells];
    return self;
}
- (void) dealloc
{
	[editCell release];
	[cell release];
	[super dealloc];
}
- (void)drawRect:(NSRect)rect
{
	NSUInteger rows = [datasource numberOfRowsInEqualizerView:self];
	NSRect bounds = [self bounds];
	NSSize cellSize = {bounds.size.width, bounds.size.height / rows};
	CGFloat y= bounds.size.height - cellSize.height;
	for (NSUInteger row=0 ; row<rows ; row++)
	{
		NSRect cellLocation = { {0, y}, cellSize };
		y -= cellSize.height;
		if (NSIntersectsRect(cellLocation, rect))
		{
			double value = [datasource equalizerView:self
										  valueAtRow:row];
			value *= IndicatorBoxes;
			[cell setDoubleValue:value];
			[cell drawWithFrame:cellLocation
						 inView:self];
		}
	}
}
- (void)mouseDown:(NSEvent *)theEvent
{
	NSUInteger rows = [datasource numberOfRowsInEqualizerView:self];
	NSPoint click = [self convertPoint:[theEvent locationInWindow]
							  fromView:nil];
	NSRect bounds = [self bounds];
	NSSize cellSize = {bounds.size.width, bounds.size.height / rows};

	trackingRow = (bounds.size.height - click.y) / cellSize.height;
	
	trackingFrame.origin.x = 0;
	trackingFrame.origin.y = bounds.size.height - ((trackingRow + 1) * cellSize.height);
	trackingFrame.size = cellSize;

	[editCell trackMouse:theEvent 
				  inRect:trackingFrame
				  ofView:self
			untilMouseUp:NO];
	
}
- (void) cellValueChanged: (id)sender
{
	if ([datasource respondsToSelector:@selector(equalizerView:setValue:atRow:)])
	{
		[datasource equalizerView:self
						 setValue:[editCell doubleValue] / IndicatorBoxes 
							atRow:trackingRow];
	}
	[self setNeedsDisplayInRect:trackingFrame];
}
@end

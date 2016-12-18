#import "MatrixFormController.h"

@implementation MatrixFormController
- (void)awakeFromNib
{
	results = [NSMutableArray new];
	[matrix removeRow: 0];
	[matrix setMode: NSTrackModeMatrix];
}
- (void)addCell: (NSCell*)aCell withLabel: (NSString*)aLabel
{
	NSCell *label = [[NSCell alloc] initTextCell: aLabel];
	[label setAlignment: NSRightTextAlignment];
	CGFloat height = [label cellSize].height + 8;

	[aCell setTarget: self];
	[aCell setAction: @selector(cellValueChanged:)];

	NSArray *cells = [NSArray arrayWithObjects:
					  label, aCell, nil];
	[matrix addRowWithCells: cells];
	[label release]; [aCell release];
	
	[results addObject: [NSNull null]];

	NSRect frame = [matrix frame];
	frame.origin.y += frame.size.height;
	frame.size.height = [matrix numberOfRows] * height;
	frame.origin.y -= frame.size.height;
	[matrix setFrame: frame];
}
- (void)addTextFieldWithLabel: (NSString*)aLabel
{
	NSCell *cell = [[NSTextFieldCell alloc] init];
	[cell setEditable: YES];
	[cell setStringValue:@""];
	[cell setBezeled: YES];
	[self addCell: cell withLabel: aLabel];
}
- (void)addBoolFieldWithLabel: (NSString*)aLabel
{
	NSButtonCell *cell = [[NSButtonCell alloc] init];
	[cell setTitle: @""];
	[cell setButtonType: NSSwitchButton];
	[self addCell: cell withLabel: aLabel];
}
- (void)addDateFieldWithLabel: (NSString*)aLabel
{
	NSDatePickerCell *cell = [NSDatePickerCell new];
	[cell setBezeled: YES];
	[cell setBackgroundColor: [NSColor whiteColor]];
	[self addCell: cell withLabel: aLabel];
}
- (void)addNumberFieldWithLabel: (NSString*)aLabel
{
	NSTextFieldCell *cell = [[NSTextFieldCell alloc] init];
	[cell setFormatter: [[NSNumberFormatter new] autorelease]];
	[cell setEditable: YES];
	[cell setStringValue:@""];
	[cell setBezeled: YES];
	[self addCell: cell withLabel: aLabel];
}
- (NSArray*)result
{
	return [results copy];
}
- (void)cellValueChanged: (id)sender
{
	NSCell *cell = [matrix selectedCell];
	[results replaceObjectAtIndex: [matrix selectedRow]
					   withObject: [cell objectValue]];
	NSLog(@"Results: %@", results);
}
@end

#import "ScriptTableController.h"

@implementation ScriptTableController
- (void)awakeFromNib
{
	ScriptTableApplication *app = 
		[SBApplication applicationWithBundleIdentifier:
			@"com.example.ScriptTable"];
	table = [[[app documents] objectAtIndex: 0] retain];
}
- (IBAction)fetchRowValue: (id)sender
{
	NSUInteger index = [sender integerValue];
	SBElementArray *rows = [table rows];
	if (index < [rows count])
	{
		ScriptTableRow *row = [rows objectAtIndex: index];
		[rowValue setStringValue: row.title];
	}
}
- (IBAction)addRow: (id)sender
{
	[table addRowDisplaying: [newRowText stringValue]];
}
- (IBAction)clearRows: (id)sender
{
	[table clearRows];
}
@end

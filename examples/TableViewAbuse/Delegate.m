#import "Delegate.h"

@implementation Delegate
-           (id)tableView: (NSTableView*)aTableView 
objectValueForTableColumn: (NSTableColumn*)aTableColumn 
					  row: (NSInteger)row
{
	NSInteger index = row / 2;
	NSString *path = [images objectAtIndex: index];
	if (row % 2 == 0)
	{
		if ([[aTableColumn identifier] isEqualToString: @"name"])
		{
			return [path lastPathComponent];
		}
		NSFileManager *fm = [NSFileManager defaultManager];
		NSDictionary *attributes = [fm fileAttributesAtPath: path
														traverseLink: YES];
		return [attributes objectForKey: NSFileSize];
	}
	return [[[NSImage alloc] initWithContentsOfFile: path] autorelease];
}
- (NSInteger)numberOfRowsInTableView: (NSTableView*)aTableView
{
	return [images count] * 2;
}
-   (NSCell*)tableView: (NSTableView*)tableView
dataCellForTableColumn: (NSTableColumn*)tableColumn
				   row: (NSInteger)row
{
	if ((tableColumn == nil) && ((row % 2) == 1))
	{
		return [[[NSImageCell alloc] init] autorelease];
	}
	return nil;
}
- (CGFloat)tableView: (NSTableView*)tableView
		 heightOfRow: (NSInteger)row
{
	if (row % 2 == 0)
	{
		return 16;
	}
	NSImage *image = [self tableView: tableView
		   objectValueForTableColumn: nil
								 row: row];
	return [image size].height;
}
- (IBAction)openImages: (id)sender
{
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection: YES];
	NSArray *types = [NSArray arrayWithObjects: @"png", @"gif", @"tiff", @"jpg", nil];
	if ([panel runModalForTypes: types] == NSOKButton)
	{
		[images release];
		images = [[panel filenames] retain];
		[view reloadData];
	}
}
@end

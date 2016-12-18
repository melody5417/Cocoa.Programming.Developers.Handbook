#import "DataSource.h"

NSString *MultipleStringRows = @"MultipleStringRows";

@implementation DataSource
- (void) awakeFromNib
{
	NSArray *types = [NSArray arrayWithObjects:
		NSStringPboardType,
		MultipleStringRows,
		nil];
	[view registerForDraggedTypes: types];
}

- (BOOL)tableView: (NSTableView*)aTableView
       acceptDrop: (id<NSDraggingInfo>)info
              row: (NSInteger)row
    dropOperation: (NSTableViewDropOperation)operation
{
	NSPasteboard *pboard = [info draggingPasteboard];

	if (operation = NSTableViewDropOn) { row--; }

	[self willChangeValueForKey: @"array"];

	if ([info draggingSource] == view)
	{
		NSIndexSet *rows = [view selectedRowIndexes];
		if (row == [array count]) { row--; }
		id placeholder = [array objectAtIndex: row];
		NSArray *moved = [array objectsAtIndexes: rows];
		[array removeObjectsAtIndexes: rows];
		row = [array indexOfObject: placeholder];
		if (row == NSNotFound) { row=0; }
		NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: 
							   NSMakeRange(row, [moved count])];
		[array insertObjects: moved
				   atIndexes: indexes];
		
	}
	else
	{
		if ([[pboard types] containsObject: MultipleStringRows])
		{
			NSArray *objects = [pboard propertyListForType: MultipleStringRows];
			NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: 
								   NSMakeRange(row, [objects count])];
			[array insertObjects: objects
					   atIndexes: indexes];
		}
		else
		{
			[array insertObject: [pboard stringForType: NSStringPboardType]
						atIndex: row];
		}
	}
	
	[self didChangeValueForKey: @"array"];
	return YES;
}
- (NSDragOperation)tableView: (NSTableView*)aTableView
                validateDrop: (id<NSDraggingInfo>)info
                 proposedRow: (NSInteger)row
       proposedDropOperation: (NSTableViewDropOperation)operation
{
	if ([info draggingSource] == view)
	{
		return NSDragOperationMove;
	}
	return NSDragOperationCopy;
}
-    (BOOL)tableView: (NSTableView*)aTableView
writeRowsWithIndexes: (NSIndexSet*)rowIndexes
        toPasteboard: (NSPasteboard*)pboard
{
	if ([rowIndexes count] == 1)
	{
		[pboard declareTypes: [NSArray arrayWithObject: NSStringPboardType]
					   owner: nil];
		[pboard setString: [array objectAtIndex: [rowIndexes firstIndex]]
				  forType: NSStringPboardType];
		return YES;
	}
	[pboard declareTypes: [NSArray arrayWithObject: MultipleStringRows]
				   owner: nil];
	[pboard setPropertyList: [array objectsAtIndexes: rowIndexes]
					forType: MultipleStringRows];
	return YES;
}
@end

#import "ColumnInspectorController.h"
#import "OutlineDocument.h"

@implementation ColumnInspectorController
- (void)awakeFromNib
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(documentChanged:)
				   name: NSWindowDidBecomeKeyNotification
				 object: nil];
	[center addObserver: self
			   selector: @selector(documentChanged:)
				   name: NSOutlineViewColumnDidMoveNotification
				 object: nil];
}
- (void) dealloc
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver: self];
	[super dealloc];
}
- (void)documentChanged: (NSNotification*)aNotification
{
	if ([[NSDocumentController sharedDocumentController] currentDocument] != nil)
	{
		[table reloadData];
	}
}
- (NSInteger)numberOfRowsInTableView: (NSTableView*)aTableView
{
	OutlineDocument *doc = [[NSDocumentController sharedDocumentController] currentDocument];
	return [[doc viewController] numberOfColumns];
}
-           (id)tableView: (NSTableView*)aTableView 
objectValueForTableColumn: (NSTableColumn*)aTableColumn
			          row: (NSInteger)rowIndex
{
	OutlineDocument *doc = [[NSDocumentController sharedDocumentController] currentDocument];
	if (aTableColumn == titleColumn)
	{
		return [[doc viewController] titleForColumnAtIndex: rowIndex];
	}
	return [[doc viewController] typeForColumnAtIndex: rowIndex];
}
- (void)tableView: (NSTableView*)aTableView
   setObjectValue: (id)anObject
   forTableColumn: (NSTableColumn*)aTableColumn 
			  row: (NSInteger)rowIndex
{
	OutlineDocument *doc = [[NSDocumentController sharedDocumentController] currentDocument];
	if (aTableColumn == titleColumn)
	{
		[[doc viewController] setTitle: anObject
				forColumnAtIndex: rowIndex];
	}
	[[doc viewController] setType: anObject
		   forColumnAtIndex: rowIndex];
}
- (IBAction) addColumn: (id) sender
{
	OutlineDocument *doc = [[NSDocumentController sharedDocumentController] currentDocument];
	[[doc viewController] addColumn];
	[table reloadData];
}
- (IBAction) removeColumn: (id) sender
{
	OutlineDocument *doc = [[NSDocumentController sharedDocumentController] currentDocument];
	[[doc viewController] removeColumnAtIndex: [table selectedRow]];
	[table reloadData];
}
@end

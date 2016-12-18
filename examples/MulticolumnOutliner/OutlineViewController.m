#import "OutlineViewController.h"
#import "OutlineDocument.h"

@implementation OutlineViewController
- (void) awakeFromNib
{
	columns = [[NSMutableArray alloc] initWithObjects: 
			   [NSMutableDictionary dictionaryWithObjectsAndKeys:
				@"title", @"title",
				@"0", @"type",
				nil], nil];
	cells = [NSMutableArray new];
	NSTextFieldCell *textCell = [[NSTextFieldCell alloc] init];
	[textCell setAllowsEditingTextAttributes: NO];
	[textCell setEditable: YES];
	[cells addObject: textCell];
	[textCell release];
	NSButtonCell *buttonCell = [[NSButtonCell alloc] init];
	[buttonCell setButtonType: NSSwitchButton];
	[buttonCell setTitle: @""];
	[buttonCell setEditable: YES];
	[cells addObject: buttonCell];
	[buttonCell release];
}
- (id)typeForColumnAtIndex: (NSUInteger)index
{
	return [[columns objectAtIndex: index] objectForKey: @"type"];
}
- (NSString*)titleForColumnAtIndex: (NSUInteger)index
{
	return [[columns objectAtIndex: index] objectForKey: @"title"];
}
- (void)setType: (id)aType forColumnAtIndex: (NSUInteger)index
{
	NSMutableDictionary *column = [columns objectAtIndex: index];
	[column setObject: aType forKey: @"type"];
	NSCell *cell = [cells objectAtIndex: [aType integerValue]];
	[[[view tableColumns] objectAtIndex: index] setDataCell: [cell copy]];
	[view reloadData];
}
- (void)setTitle: (NSString*)aTitle forColumnAtIndex: (NSUInteger)index
{
	NSMutableDictionary *column = [columns objectAtIndex: index];
	[column setObject: aTitle forKey: @"title"];
	NSTableColumn *tableColumn = [[view tableColumns] objectAtIndex: index];
	[[tableColumn headerCell] setStringValue: aTitle];
	[tableColumn setIdentifier: aTitle];
}
- (NSUInteger)numberOfColumns
{
	return [columns count];
}
- (id)outlineView: (NSOutlineView *)outlineView
			child: (NSInteger)index
		   ofItem: (OutlineItem*)item
{
	if (item == nil)
	{
		return [document root];
	}
	return [item.children objectAtIndex: index];
}
- (NSInteger)outlineView: (NSOutlineView*)outlineView
  numberOfChildrenOfItem: (OutlineItem*)item
{
	if (item == nil)
	{
		return 1;
	}
	return [item.children count];
}
- (BOOL)outlineView: (NSOutlineView*)outlineView 
   isItemExpandable: (OutlineItem*)item
{
	return [item.children count] > 0;
}
-         (id)outlineView: (NSOutlineView*)outlineView
objectValueForTableColumn: (NSTableColumn*)tableColumn
				   byItem: (id)item
{
	return [item valueForKey: [tableColumn identifier]];
}
- (void)outlineView: (NSOutlineView*)outlineView
	 setObjectValue: (id)object
	 forTableColumn: (NSTableColumn*)tableColumn
			 byItem: (id)item
{
	[item setValue: object forKey: [tableColumn identifier]];
}

- (IBAction)insertChild: (id)sender
{
	OutlineItem *selected = [view itemAtRow: [view selectedRow]];
	if (selected == nil)
	{
		selected = [document root];
	}
	[selected insertObject: [[OutlineItem new] autorelease]
		 inChildrenAtIndex: [selected.children count]];
	[view reloadItem: selected reloadChildren: YES];
	[view expandItem: selected];
}
- (IBAction)removeChild: (id)sender
{
	NSUInteger row = [view selectedRow];
	OutlineItem *selected = [view itemAtRow: row];
	OutlineItem *parent = [view parentForItem: selected];
	[parent removeObjectFromChildren: selected];
	[view reloadItem: parent reloadChildren: YES];
}
- (void) addColumn
{
	[columns addObject: [NSMutableDictionary dictionaryWithObjectsAndKeys:
						 @"newColumn", @"title",
						 @"0", @"type",
						 nil]];
	NSTableColumn *newColumn = [[NSTableColumn alloc] initWithIdentifier: @"newColumn"];
	[newColumn setDataCell: [[cells objectAtIndex: 0] copy]];
	[view addTableColumn: newColumn];
	[view reloadData];
}
- (void) removeColumnAtIndex: (NSUInteger) index
{
	NSTableColumn *column = [[view tableColumns] objectAtIndex: index];
	[columns removeObjectAtIndex: index];
	[view removeTableColumn: column];
	[view reloadData];
}
- (void)outlineViewColumnDidMove: (NSNotification*)notification
{
	NSDictionary *userInfo = [notification userInfo];
	NSInteger oldIndex = [[userInfo objectForKey: @"NSOldColumn"] integerValue];
	NSInteger newIndex = [[userInfo objectForKey: @"NSNewColumn"] integerValue];
	id column = [[columns objectAtIndex: oldIndex] retain];
	[columns removeObjectAtIndex: oldIndex];
	[columns insertObject: column atIndex: newIndex];
	[column release];
}
@end

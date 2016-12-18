#import "OutlineDataSource.h"

@implementation OutlineDataSource
@synthesize root;
- (id)init
{
	if (nil == (self = [super init]))
	{
		return nil;
	}
	root = [OutlineItem new];
	root.title = @"Root";
	return self;
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(OutlineItem*)item
{
	if (nil == item)
	{
		return root;
	}
	return [item.children objectAtIndex:index];
}
- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(OutlineItem*)item
{
	if (item == nil)
	{
		return YES;
	}
	return [item.children count] > 0;
}
- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(OutlineItem*)item
{
	if (item == nil)
	{
		return 1;
	}	
	return [item.children count];
}
-         (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
                   byItem:(OutlineItem*)item
{
	return item.title;
}
- (void)outlineView:(NSOutlineView *)outlineView
     setObjectValue:(id)object
     forTableColumn:(NSTableColumn *)tableColumn
             byItem:(OutlineItem*)item
{
	item.title = object;
}
- (void) dealloc
{
	[root release];
	[super dealloc];
}
@end

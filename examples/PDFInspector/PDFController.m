#import "PDFController.h"

@implementation PDFController
@synthesize document;
- (void)awakeFromNib
{
	NSNotificationCenter *center = 
		[NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(pageChanged:)
				   name: PDFViewPageChangedNotification
				 object: view];
	[center addObserver: self
			   selector: @selector(pageChanged:)
				   name: PDFViewDocumentChangedNotification
				 object: view];
}
- (IBAction)open: (id)sender
{
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel runModalForTypes: [NSArray arrayWithObject: @"pdf"]];
	NSURL *url = [NSURL fileURLWithPath: [panel filename]];
	self.document = [[[PDFDocument alloc] initWithURL: url] autorelease];
	[view setDocument: document];
	[outline reloadData];
}
- (id)outlineView: (NSOutlineView*)outlineView
            child: (NSInteger)index
           ofItem: (PDFOutline*)item
{
	if (nil == item)
	{
		item = [document outlineRoot];
	}
	return [item childAtIndex: index];
}
- (BOOL)outlineView: (NSOutlineView *)outlineView
   isItemExpandable: (PDFOutline*)item
{
	if (item == nil)
	{
		return YES;
	}
	return [item numberOfChildren] > 0;
}
- (NSInteger)outlineView: (NSOutlineView *)outlineView
  numberOfChildrenOfItem: (PDFOutline*)item
{
	if (item == nil)
	{
		item = [document outlineRoot];
	}	
	return [item numberOfChildren];
}
-         (id)outlineView: (NSOutlineView*)outlineView
objectValueForTableColumn: (NSTableColumn*)tableColumn
                   byItem: (PDFOutline*)item
{
	return [item label];
}
- (void)pageChanged: (NSNotification*)aNotification
{
	NSAttributedString *text = [[view currentPage] attributedString];
	[[textView textStorage] setAttributedString: text];
}
- (void)outlineViewSelectionDidChange: (NSNotification*)notification
{
	PDFOutline *item = [outline itemAtRow: [outline selectedRow]];
	[view goToPage: [[item destination] page]];
}
@end

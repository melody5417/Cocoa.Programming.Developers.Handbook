#import "AnnotationController.h"

@implementation AnnotationController
- (void)awakeFromNib
{
	NSNotificationCenter *center = 
	[NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(pageChanged:)
				   name: PDFViewPageChangedNotification
				 object: view];
}
- (IBAction)open: (id)sender
{
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel runModalForTypes: [NSArray arrayWithObject: @"pdf"]];
	NSURL *url = [NSURL fileURLWithPath: [panel filename]];
	[document release];
	document = [[PDFDocument alloc] initWithURL: url];
	for (NSUInteger i=0 ; i<[document pageCount] ; i++)
	{
		PDFPage *page = [document pageAtIndex: i];
		[page setDisplaysAnnotations: NO];
		for (PDFAnnotation *note in [page annotations])
		{
			PDFAnnotationPopup *popup = [note popup];
			if ([popup isOpen])
			{
				[popup setIsOpen: NO];
			}
		}		
	}
	[view setDocument: document];
	[self pageChanged: nil];
}
- (void)pageChanged: (NSNotification*)aNotification
{
	PDFPage *page = [view currentPage];
	NSMutableString *notes = [NSMutableString string];
	for (PDFAnnotation *note in [page annotations])
	{
		NSString *contents = [note contents];
		if (contents != nil)
		{
			[notes appendString: [note contents]];
		}
	}
	NSRange range = NSMakeRange(0, [[noteBox textStorage] length]);
	[[noteBox textStorage] replaceCharactersInRange: range
										 withString: notes];
}
@end

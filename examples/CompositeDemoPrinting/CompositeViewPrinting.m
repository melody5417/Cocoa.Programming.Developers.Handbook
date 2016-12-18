#import <Cocoa/Cocoa.h>
#import "PrintPanelController.h"
#import "CompositeView.h"

static int imagesPerPage(void)
{
	NSPrintInfo *info = [[NSPrintOperation currentOperation] printInfo];
	NSDictionary *dict = [info dictionary];
	return [[dict objectForKey:@"imagesPerPage"] intValue];
}


@implementation CompositeView (Printing)
- (void) print:(id)sender
{
	PrintPanelController *controller =
		[[PrintPanelController alloc] initWithNibName: @"PrintView"
											   bundle: [NSBundle mainBundle]];
	[controller setTitle:@"Images Per Page"];
	NSPrintPanel *panel = [NSPrintPanel printPanel];
	[panel setOptions:NSPrintPanelShowsPreview];
	[panel addAccessoryController:controller];
	[controller release];
	
	NSPrintOperation *op = [NSPrintOperation printOperationWithView:self];
	[op setPrintPanel:panel];
	SEL completeSel = 
		@selector(printOperationDidRun:success:contextInfo:);
	[op runOperationModalForWindow:[self window]
						  delegate:nil
					didRunSelector:completeSel
					   contextInfo:NULL];
}

- (BOOL)knowsPageRange:(NSRangePointer)range
{
	range->location	= 1;
	int images = imagesPerPage();
	range->length = 14 / images;
	if (14 % images)
	{
		range->length++;
	}
    return YES;
}

- (NSRect)rectForPage:(int)page 
{
    NSRect bounds = [self bounds];
	bounds.size.width /= 7;
	int images = imagesPerPage();
	int columns = images / 2;
	bounds.size.width *= columns;
	bounds.origin.x = bounds.size.width * (page-1);
	return NSIntersectionRect(bounds, [self bounds]);
}
@end

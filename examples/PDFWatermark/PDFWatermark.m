#import "PDFWatermark.h"
#import <Quartz/Quartz.h>

@implementation PDFWatermark
- (IBAction)open: (id)sender
{
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel runModalForTypes: [NSArray arrayWithObject: @"pdf"]];
	NSURL *url = [NSURL fileURLWithPath: [panel filename]];
	PDFDocument *doc = [[PDFDocument alloc] initWithURL: url];
	[pdf setDisplaysPageBreaks: NO];
	[pdf setDocument: doc];
	[doc release];
	[self applyWatermark: self];
}
- (IBAction)applyWatermark: (id)sender
{
	[waterMark removeFromSuperview];
	NSView *pdfDocView = [pdf documentView];
	waterMark = [[NSImageView alloc] initWithFrame: [pdfDocView bounds]];
	[pdfDocView addSubview: waterMark];
	[waterMark setImage: [waterMarkWell image]];
	[waterMark release];
}
- (IBAction)export: (id)sender
{
	NSView *pdfDocView = [pdf documentView];
	NSData *pdfData = 
		[pdfDocView dataWithPDFInsideRect: [pdfDocView bounds]];
	NSString *savePath =
		[@"~/Desktop/WatermarkedPDFPage.pdf" stringByExpandingTildeInPath];
	[pdfData writeToFile: savePath
			  atomically: NO];
}
@end

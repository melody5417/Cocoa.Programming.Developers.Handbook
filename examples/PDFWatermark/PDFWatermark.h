#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface PDFWatermark : NSObject {
	IBOutlet PDFView *pdf;
	IBOutlet NSImageView *waterMarkWell;
	PDFPage *page;
	NSImageView *waterMark;
}
- (IBAction)open: (id)sender;
- (IBAction)export: (id)sender;
- (IBAction)applyWatermark: (id)sender;
@end

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface PDFController : NSObject {
	PDFDocument *document;
	IBOutlet PDFView *view;
	IBOutlet PDFThumbnailView *thumbs;
	IBOutlet NSOutlineView *outline;
	IBOutlet NSTextView *textView;
}
@property (nonatomic, retain) PDFDocument *document;
- (IBAction)open: (id)sender;
@end

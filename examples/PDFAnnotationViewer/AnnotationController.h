#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface AnnotationController : NSObject {
	IBOutlet PDFView *view;
	IBOutlet NSTextView *noteBox;
	PDFDocument *document;
}
- (IBAction)open: (id)sender;
- (void)pageChanged: (NSNotification*)aNotification;
@end

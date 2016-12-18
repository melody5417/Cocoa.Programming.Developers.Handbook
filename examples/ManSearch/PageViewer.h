#import <Cocoa/Cocoa.h>

@interface PageViewer : NSObject {
	IBOutlet NSTextView *view;
	IBOutlet NSArrayController *pages;
}
@end

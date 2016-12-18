#import <Cocoa/Cocoa.h>


@interface SheetRunner : NSObject {
	IBOutlet NSWindow *sheet;
	IBOutlet NSTextField *result;
}
- (IBAction)runSheet: (id)sender;
- (IBAction)endSheet: (id)sender;
@end

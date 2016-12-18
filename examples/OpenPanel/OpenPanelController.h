#import <Cocoa/Cocoa.h>

@interface OpenPanelController : NSObject {
	IBOutlet NSTextField *filename;
}
- (IBAction)runSheet: (id)sender;
- (IBAction)runModal: (id)sender;
- (IBAction)runModeless: (id)sender;
@end

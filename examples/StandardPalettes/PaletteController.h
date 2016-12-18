#import <Cocoa/Cocoa.h>

@interface PaletteController : NSObject {
	IBOutlet NSTextField *text;
}
- (IBAction)showFontPanel: (id)sender;
- (IBAction)showColorPanel: (id)sender;
@end

#import <Cocoa/Cocoa.h>

@interface WindowFactory : NSObject {
	IBOutlet NSButton *isTextured;
	IBOutlet NSButton *isOpaque;
	IBOutlet NSButton *isTitled;
	IBOutlet NSButton *hasShadow;
	IBOutlet NSTextField *title;
}
- (IBAction)createWindowFromNib: (id)sender;
- (IBAction)createWindowInCode: (id)sender;
@end

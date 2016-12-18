#import <InterfaceBuilderKit/InterfaceBuilderKit.h>

@interface CircleTextInspector : IBInspector {
	IBOutlet NSTextField *text;
	IBOutlet NSTextField *padding;
}
- (IBAction) textChanged:(id) sender;
- (IBAction) paddingChanged:(id) sender;
@end

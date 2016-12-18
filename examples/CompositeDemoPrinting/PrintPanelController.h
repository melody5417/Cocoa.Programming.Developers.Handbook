#import <Cocoa/Cocoa.h>

@interface PrintPanelController : NSViewController 
		<NSPrintPanelAccessorizing> {
	IBOutlet NSSlider *slider;
}
- (IBAction) setPagesFromSlider:(id)sender;
@end

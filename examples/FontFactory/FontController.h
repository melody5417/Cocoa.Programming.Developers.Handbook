#import <Cocoa/Cocoa.h>

@interface FontController : NSObject {
	IBOutlet NSTextField *text;
}
- (IBAction)setFontName: (id)sender;
- (IBAction)setFontSize: (id)sender;
- (IBAction)setFontAttribute: (id)sender;
@end

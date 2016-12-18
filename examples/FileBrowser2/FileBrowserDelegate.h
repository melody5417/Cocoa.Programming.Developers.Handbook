#import <Cocoa/Cocoa.h>

@interface FileBrowserDelegate : NSObject {
	IBOutlet NSBrowser *browser;
	NSArray *directoryContents;
}
- (IBAction)openFile: (id) sender;
@end
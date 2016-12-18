#import <Cocoa/Cocoa.h>

@class FileBrowser;

@interface InspectorController : NSObject {
	IBOutlet NSImageView *icon;
	IBOutlet NSTextField *size;
	IBOutlet NSTextField *owner;
	IBOutlet NSTextField *filename;
	FileBrowser *currentDocument;
}
@end

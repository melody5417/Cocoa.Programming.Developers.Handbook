#import <Cocoa/Cocoa.h>

@interface FileBrowser : NSDocument {
	IBOutlet NSBrowser *browser;
	NSArray *directoryContents;
	IBOutlet NSArrayController *arrayController;
}
@property (nonatomic, readonly) NSArrayController *arrayController;
- (NSString*) fileAtIndex: (NSUInteger)anIndex;
@end
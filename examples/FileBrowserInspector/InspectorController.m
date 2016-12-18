#import "InspectorController.h"
#import "FileBrowser.h"

@implementation InspectorController
- (void) awakeFromNib
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver: self
			   selector: @selector(windowChanged:)
				   name: NSWindowDidBecomeMainNotification
				 object: nil];
}
- (void) windowChanged: (NSNotification*)notification
{
	NSWindow *window = [notification object];
	FileBrowser *doc = [[window windowController] document];
	if (currentDocument != doc)
	{
		[currentDocument.arrayController removeObserver: self
											forKeyPath: @"selectionIndex"];
		[doc.arrayController addObserver: self
							  forKeyPath: @"selectionIndex"
								 options: NSKeyValueObservingOptionNew 
								 context: NULL];
		currentDocument = doc;
	}
}
- (void)observeValueForKeyPath: (NSString*)keyPath
					  ofObject: (id)object
                        change: (NSDictionary*)change
                       context: (void *)context
{
	NSInteger index = [currentDocument.arrayController selectionIndex];
	if (index == NSNotFound) { return; }

	NSString *file = [currentDocument fileAtIndex: index];

	[icon setImage: [[NSWorkspace sharedWorkspace] iconForFile: file]];

	NSFileManager *fm = [NSFileManager defaultManager];
	NSDictionary *attributes = 
		[fm attributesOfItemAtPath: file error: nil];
	[size setStringValue: 
		[attributes objectForKey: NSFileSize]];
	[owner setStringValue: 
 		[attributes objectForKey: NSFileOwnerAccountName]];

	[filename setStringValue: [file lastPathComponent]];
}
@end

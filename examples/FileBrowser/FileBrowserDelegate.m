#import "FileBrowserDelegate.h"

@implementation FileBrowserDelegate
- (void) awakeFromNib
{
	[browser setTakesTitleFromPreviousColumn: YES];
	[browser setTitled: YES];
	[browser setTitle: @"/" ofColumn: 0];
	[browser setColumnResizingType: NSBrowserUserColumnResizing];
	[browser setDoubleAction: @selector(openFile:)];
	[browser setTarget: self];
}
-     (void)browser: (NSBrowser*)sender
createRowsForColumn: (NSInteger)column
		   inMatrix: (NSMatrix*)matrix
{
	NSSize iconSize = [matrix cellSize];
	iconSize.width = iconSize.height;
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *path = [@"/" stringByAppendingPathComponent: [sender path]];
	NSArray *files = [fm directoryContentsAtPath: path];
	for (NSString *file in files)
	{
		NSString *filePath = [path stringByAppendingPathComponent: file];
		BOOL isDir = NO;
		NSBrowserCell *cell = [[NSBrowserCell alloc] init];
		if (([fm fileExistsAtPath: filePath isDirectory: &isDir] && !isDir)
			|| [[filePath pathExtension] isEqualToString: @"app"])
		{
			NSImage *icon =	[[NSWorkspace sharedWorkspace] iconForFile: filePath];
			[icon setSize: iconSize];
			[cell setImage: icon];
			[cell setLeaf: YES];
		}
		[cell setTitle: file];
		[matrix addRowWithCells: [NSArray arrayWithObject: cell]];
		[cell release];
	}
}
- (void) openFile: (id) sender
{
	[[NSWorkspace sharedWorkspace] openFile: [browser path]];
}
@end

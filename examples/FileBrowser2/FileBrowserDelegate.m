#import "FileBrowserDelegate.h"

static NSWorkspace *ws;
static NSFileManager *fm;

@implementation FileBrowserDelegate
+ (void) initialize
{
	ws = [NSWorkspace sharedWorkspace];
	fm = [NSFileManager defaultManager];
}
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
	NSString *path = [@"/" stringByAppendingPathComponent: [sender path]];
	NSArray *files = [fm directoryContentsAtPath: path];
	NSMutableArray *fileImages = [NSMutableArray new];
	for (NSString *file in files)
	{
		NSString *filePath = [path stringByAppendingPathComponent: file];
		BOOL isDir = NO;
		if (([fm fileExistsAtPath: filePath isDirectory: &isDir] && isDir)
			&& ![[filePath pathExtension] isEqualToString: @"app"])
		{
			NSBrowserCell *cell = [[NSBrowserCell alloc] init];
			[cell setTitle: file];
			[matrix addRowWithCells: [NSArray arrayWithObject: cell]];
			[cell release];
		}
		else
		{
			NSDictionary *icon = [NSDictionary dictionaryWithObjectsAndKeys:
				[ws iconForFile: filePath], @"icon",
				file, @"name",
				nil];
			[fileImages addObject: icon];
		}
	}
	[self willChangeValueForKey: @"directoryContents"];
	[directoryContents release];
	directoryContents = [fileImages retain];
	[self didChangeValueForKey: @"directoryContents"];	
}
@end

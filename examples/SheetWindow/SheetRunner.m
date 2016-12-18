#import "SheetRunner.h"

@implementation SheetRunner
- (IBAction)runSheet: (id)sender
{
	[NSApp beginSheet:sheet
	   modalForWindow: [sender window]
		modalDelegate: self
	   didEndSelector: @selector(sheetDidEnd:returnCode:contextInfo:)
		  contextInfo: NULL];
}
- (void)sheetDidEnd: (NSWindow*)sheet
		 returnCode:(int)returnCode
		contextInfo:(void *)contextInfo
{
	[result setIntValue: returnCode];
}
- (IBAction)endSheet: (id)sender
{
	[NSApp endSheet: [sender window]
		 returnCode: [sender tag]];
	[[sender window] orderOut: self];
}
@end

#import "OpenPanelController.h"

@implementation OpenPanelController
- (void)openPanelDidEnd: (NSOpenPanel*)panel
			 returnCode: (int)returnCode
			contextInfo: (void *)contextInfo
{
	[filename setStringValue: [panel filename]];
	[panel release];
}
- (IBAction)runSheet: (id)sender
{
	NSOpenPanel *panel = [[NSOpenPanel alloc] init];
	[panel beginSheetForDirectory: nil
							 file: nil
				   modalForWindow: [sender window]
					modalDelegate: self
				   didEndSelector: @selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo: NULL];
}
- (IBAction)runModal: (id)sender
{
	NSOpenPanel *panel = [[NSOpenPanel alloc] init];
	int returnCode = [panel runModal];
	[self openPanelDidEnd: panel
			   returnCode: returnCode
			  contextInfo: NULL];
}
- (IBAction)runModeless: (id)sender
{
	NSOpenPanel *panel = [[NSOpenPanel alloc] init];
	[panel beginForDirectory: nil
						file: nil
					   types: nil
			modelessDelegate: self
			  didEndSelector: @selector(openPanelDidEnd:returnCode:contextInfo:)
				 contextInfo: NULL];	
}
@end

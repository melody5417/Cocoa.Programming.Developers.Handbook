#import "MoviePlayer.h"

@implementation MoviePlayer
@synthesize movie;
- (IBAction)open: (id)sender
{
	NSOpenPanel *panel = [[NSOpenPanel alloc] init];
	[panel setAllowedFileTypes: 
	   [QTMovie movieFileTypes: QTIncludeAllTypes]];
	[panel beginSheetForDirectory: nil
							 file: nil
				   modalForWindow: window
					modalDelegate: self
				   didEndSelector: @selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo: NULL];
}
- (void)openPanelDidEnd: (NSOpenPanel*)panel
			 returnCode: (int)returnCode
			contextInfo: (void *)contextInfo
{
	self.movie = [QTMovie movieWithFile: [panel filename]
								  error: NULL];
	[movie setAttribute: [NSNumber numberWithBool: loop]
				 forKey: QTMovieLoopsAttribute];
	[window setTitle: [[panel filename] lastPathComponent]];
	[panel release];
}
- (IBAction)setLoop: (id)sender
{
	loop = [sender state] == NSOnState;
	[movie setAttribute: [NSNumber numberWithBool: loop]
				 forKey: QTMovieLoopsAttribute];
}
	
@end

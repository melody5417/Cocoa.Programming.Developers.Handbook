#import "PaletteController.h"

@implementation PaletteController
- (IBAction)showFontPanel: (id)sender
{
	NSFontPanel *panel = [NSFontPanel sharedFontPanel];
	[panel orderFront: self];
	NSFontManager *manager = [NSFontManager sharedFontManager];
	[manager setTarget: self];
	[manager setAction: @selector(fontChanged:)];
}
- (IBAction)showColorPanel: (id)sender
{
	NSColorPanel *panel = [NSColorPanel sharedColorPanel];
	[panel orderFront: self];
	[panel setTarget: self];
	[panel setAction: @selector(colorChanged:)];
}
- (void)fontChanged: (NSFontManager*)manager
{
	[text setFont: [manager convertFont: [text font]]];
}
- (void)colorChanged: (NSColorPanel*)panel
{
	[text setBackgroundColor: [panel color]];
}
@end

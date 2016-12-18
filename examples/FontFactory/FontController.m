#import "FontController.h"

NSFontManager *fm;

@implementation FontController
- (void) awakeFromNib
{
	fm = [NSFontManager sharedFontManager];
}
- (IBAction)setFontName: (id)sender
{
	NSFont *font = [text font];
	font = [fm convertFont: font
				  toFamily: [sender stringValue]];
	[text setFont: font];
}
- (IBAction)setFontSize: (id)sender
{
	NSFont *font = [text font];
	font = [fm convertFont: font
					toSize: [sender doubleValue]];
	[text setFont: font];
}	
- (IBAction)setFontAttribute: (id)sender
{
	NSFont *font = [text font];
	NSFontTraitMask attribute = [sender tag];
	if ([sender state] == NSOnState)
	{
		font = [fm convertFont: font
				   toHaveTrait: attribute];
	}
	else
	{
		font = [fm convertFont: font
				toNotHaveTrait: attribute];
	}
	[sender setState: ([fm traitsOfFont: font] & attribute)];
	[text setFont: font];
}
@end

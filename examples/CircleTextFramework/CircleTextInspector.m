#import "CircleTextInspector.h"
#import "CircleTextView.h"

@implementation CircleTextInspector

- (NSString *)viewNibName 
{
	return @"CircleTextInspector";
}

- (void)refresh
{
	[super refresh];
	NSArray *selection = [self inspectedObjects];
	if ([selection count] > 1)
	{
		[text setStringValue:@""];
	}
	else
	{
		NSAttributedString *str = [[selection objectAtIndex:0] attributedStringValue];
		if (nil != str)
		{
			[text setAttributedStringValue:str];
		}
	}
}

- (IBAction) textChanged:(id) sender
{
	NSArray *selection = [self inspectedObjects];
	NSAttributedString *string = [[text attributedStringValue] copy];
	for (CircleTextView *view in selection)
	{
		[view setAttributedStringValue:string];
		[view setNeedsDisplay:YES];
	}
}
- (IBAction) paddingChanged:(id) sender
{
	NSArray *selection = [self inspectedObjects];
	CGFloat paddingValue = [padding doubleValue];

	for (CircleTextView *view in selection)
	{
		[view setPadding:paddingValue];
		[view setNeedsDisplay:YES];
	}	
}
@end

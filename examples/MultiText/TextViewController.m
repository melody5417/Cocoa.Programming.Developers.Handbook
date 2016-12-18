#import "TextViewController.h"


@implementation TextViewController
- (IBAction) addColumn:(id)sender
{
	NSRect frame = [columnView frame];
	NSTextContainer *container = 
		[[NSTextContainer alloc] initWithContainerSize:frame.size];
	[container setHeightTracksTextView:YES];
	[container setWidthTracksTextView:YES];
	[secondLayout addTextContainer:container];
	[container release];
	NSTextView *newView = [[NSTextView alloc] initWithFrame:frame 
											 textContainer:container];
	[columnView addSubview:newView];
	[newView release];
}	
- (void)awakeFromNib
{
	// Get the store
	NSTextStorage *storage = [bottomView textStorage];
	// Add a second layout manager
	secondLayout = [[NSLayoutManager alloc] init];
	[storage addLayoutManager:secondLayout];
	[secondLayout release];
	
	// Create the columns
	[self addColumn:self];
	[self addColumn:self];
}
@end

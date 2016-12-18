#import "ClickTextView.h"

@interface TextClip : NSObject {
@public
	NSString *text;
	NSPoint location;
}
@end
@implementation TextClip
- (NSString*) description
{
	return [NSString stringWithFormat:@"clip (%@) at %@", 
		   text, 
		   NSStringFromPoint(location)];
}
- (void) dealloc
{
	[text release];
	[super dealloc];
}
@end

@implementation ClickTextView
- (void) awakeFromNib
{
	texts = [[NSMutableArray alloc] init];
	cell = [[NSTextFieldCell alloc] initTextCell:@""];
	[cell setEditable:YES];
	[cell setShowsFirstResponder:YES];
}
- (void)mouseDown:(NSEvent *)theEvent
{
	currentLocation = [self convertPoint:[theEvent locationInWindow]
								fromView:nil];
	NSText *fieldEditor = [[self window] fieldEditor:YES
										   forObject:self];
	[cell endEditing:fieldEditor];
	[fieldEditor setString:@""];
	[cell setStringValue:@""];
	NSRect frame = {currentLocation, {400, 30}};
	[cell editWithFrame:frame
				 inView:self
				 editor:fieldEditor
			   delegate:self
				  event:theEvent];
}
- (BOOL) isFlipped
{
	return YES;
}
- (void)drawRect:(NSRect)rect
{
	NSRect frame = rect;
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect:rect];
	for (TextClip *clip in texts)
	{
		[cell setStringValue:clip->text];
		frame.origin=clip->location;
		[cell drawWithFrame:frame inView:self];
	}
}
- (void) textDidEndEditing: (NSNotification *)aNotification
{
	NSText *text = [aNotification object];
	TextClip *clip = [[TextClip alloc] init];
	clip->text = [[text string] copy];
	clip->location = currentLocation;
	[texts addObject:clip];
	[clip release];

	[cell endEditing:text];
	[self setNeedsDisplay:YES];
}
- (void) dealloc
{
	[texts release];
	[cell release];
	[super dealloc];
}
@end

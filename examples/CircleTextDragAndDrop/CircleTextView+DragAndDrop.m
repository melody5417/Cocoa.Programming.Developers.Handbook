#import "CircleTextView.h"
#import "CircleTextCell.h"

@implementation CircleTextView (Drag)
- (void)mouseDragged:(NSEvent *)theEvent
{
	NSPasteboard *pboard = [NSPasteboard pasteboardWithName: NSDragPboard];
	
	NSArray *types = [NSArray arrayWithObjects:
		NSPDFPboardType,
		NSRTFPboardType,
		NSStringPboardType,
		nil];
	
	[pboard declareTypes: types
				   owner: self];
	
	NSPoint click = [self convertPoint: [theEvent locationInWindow]
                              fromView: nil];

	NSData *imageData = [self dataWithPDFInsideRect: [self bounds]];
	NSImage *dragImage = [[NSImage alloc] initWithData: imageData];
	[dragImage setSize: NSMakeSize(40, 40)];
	
	[self dragImage: dragImage
				 at: click
			 offset: NSZeroSize
			  event: theEvent
		 pasteboard: pboard
			 source: self
		  slideBack: YES];
	[dragImage release];
}
- (NSDragOperation)draggingSourceOperationMaskForLocal: (BOOL)isLocal
{
	return NSDragOperationCopy | NSDragOperationDelete | NSDragOperationMove;
}
- (void)pasteboard: (NSPasteboard*)pboard
provideDataForType: (NSString*)type
{
	if (type == NSStringPboardType)
	{
		[pboard setString: [cell stringValue]
				  forType: NSStringPboardType];
	}
	else if (type == NSRTFPboardType)
	{
		NSAttributedString *str = [cell attributedStringValue];
		NSData *rtf = [str RTFFromRange: NSMakeRange(0, [str length])
					 documentAttributes: nil];
		[pboard setData: rtf
				forType: NSRTFPboardType];
	}
	else if (type == NSPDFPboardType)
	{
		[self writePDFInsideRect: [self bounds]
					toPasteboard: pboard];
	}
}
- (void)draggedImage: (NSImage*)anImage 
			 endedAt: (NSPoint)aPoint 
		   operation: (NSDragOperation)operation
{
	NSDragOperation deleteMask = NSDragOperationDelete | NSDragOperationMove;
	if ((deleteMask & operation) != 0)
	{
		[cell setStringValue: @""];
		[self setNeedsDisplay: YES];
	}
	if ((operation & NSDragOperationDelete) != 0)
	{
		NSShowAnimationEffect(NSAnimationEffectPoof,
			aPoint, NSZeroSize, nil, 0, NULL);
	}
}
@end
@implementation CircleTextView (Drop)
- (NSDragOperation)draggingEntered: (id<NSDraggingInfo>)sender
{
	NSDragOperation op = [sender draggingSourceOperationMask];
	if ((op & NSDragOperationCopy) != 0)
	{
		return NSDragOperationCopy;
	}
	if ((op & NSDragOperationMove) != 0)
	{
		return NSDragOperationMove;
	}
	return NSDragOperationNone;
}
- (BOOL)performDragOperation: (id<NSDraggingInfo>)sender
{
	NSPasteboard *pboard = [sender draggingPasteboard];
	NSArray *types = [pboard types];
	BOOL didDrop = NO;
	if ([types containsObject: NSRTFPboardType])
	{
		NSData *data = [pboard dataForType: NSRTFPboardType];
		NSAttributedString *str =
			[[NSAttributedString alloc] initWithRTF: data
								 documentAttributes: nil];
		[cell setAttributedStringValue: str];
		didDrop = YES;
	}
	else if ([types containsObject: NSStringPboardType])
	{
		[cell setStringValue: [pboard stringForType: NSStringPboardType]];
		didDrop = YES;
	}
	if (didDrop)
	{
		[self setNeedsDisplay: YES];
		return YES;
	}
	return NO;
}
@end

#import "CircleTextView.h"
#import "CircleTextCell.h"

@implementation CircleTextView
- (void) writeViewToTiffFile:(NSString*)aFile resolution:(NSSize)aSize
{
	NSGraphicsContext * context = [NSGraphicsContext currentContext];
	NSBitmapImageRep *bitmap =
		[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
												pixelsWide:aSize.width
												pixelsHigh:aSize.height
											 bitsPerSample:8
										   samplesPerPixel:4
												  hasAlpha:YES 
												  isPlanar:NO
											colorSpaceName:NSCalibratedRGBColorSpace
											   bytesPerRow:0
											  bitsPerPixel:0];
	NSGraphicsContext *bitmapContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:bitmap];
	[NSGraphicsContext setCurrentContext:bitmapContext];
	NSRect drawRect = { {0,0}, aSize};
	NSRect bounds = [self bounds];
	[self setBounds:drawRect];
	[self drawRect:drawRect];
	[self setBounds:bounds];
	[[bitmap TIFFRepresentation] writeToFile:aFile
								  atomically:NO];
	[bitmap release];
	[NSGraphicsContext setCurrentContext:context];
}
- (void) awakeFromNib
{
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSFont fontWithName:@"Zapfino" size:32],
								NSFontAttributeName,
								nil];
	NSAttributedString *str = 
	[[NSAttributedString alloc] initWithString: @"Hello world! This is a long string which will be wrapped into a circle by a cell."
									attributes:attributes];
	
	cell = [[CircleTextCell alloc] init];
	[cell setAttributedStringValue:str];
	[cell setPadding:20];
	[self writeViewToTiffFile:[@"~/Desktop/tmp.tiff" stringByExpandingTildeInPath]
				   resolution:NSMakeSize(1024,1024)];
}
- (void)drawRect:(NSRect)rect
{
	[[NSColor whiteColor] setFill];
	[NSBezierPath fillRect:rect];
	[cell drawWithFrame:[self bounds]
				 inView:self];
}
@end

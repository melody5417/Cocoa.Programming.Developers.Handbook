#import "CompositeView.h"

@implementation CompositeView
- (void) setSrc:(NSImage*)aSource dst:(NSImage*)aDestination
{
	src = aSource;
	dst = aDestination;
}
- (void)drawRect:(NSRect)rect
{
	NSCompositingOperation op = NSCompositeClear;
	NSRect bounds = [self bounds];
	NSSize imageSize = bounds.size;
	imageSize.width /= 7;
	imageSize.height /= 2;
	NSRect srcRect = { {0,0}, [src size] };
	NSRect dstRect = { {0,0}, [dst size] };
	for (unsigned y=0 ; y<2 ; y++)
	{
		for (unsigned x=0 ; x<7 ; x++)
		{
			NSRect drawRect;
			drawRect.origin.x = x*imageSize.width;
			drawRect.origin.y = y*imageSize.height;
			drawRect.size = imageSize;
			if (NSIntersectsRect(drawRect, rect))
			{
				[src drawInRect:drawRect
					   fromRect:srcRect
					  operation:NSCompositeCopy
					   fraction:1];
				[dst drawInRect:drawRect
					   fromRect:dstRect
					  operation:op++
					   fraction:0.5];
			}
		}
	}
}

@end

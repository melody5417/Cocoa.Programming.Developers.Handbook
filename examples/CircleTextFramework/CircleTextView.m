#import "CircleTextView.h"
#import "CircleTextCell.h"

@implementation CircleTextView
- (void) createCell
{
	[cell release];
	cell = [[CircleTextCell alloc] init];
}
- (void) dealloc
{
	[cell release];
	[super dealloc];
}
- (void) awakeFromNib
{
	[self createCell];
}
- (id)initWithFrame:(NSRect)frame
{
    if (nil == (self = [super initWithFrame:frame]))
	{
		return nil;
	}
	[self createCell];
    return self;
}
- (void) setAttributedStringValue:(NSAttributedString*)aString
{
	[cell setAttributedStringValue:aString];
}
- (NSAttributedString*) attributedStringValue
{
	return [cell attributedStringValue];
}
- (void) setPadding:(CGFloat)padding
{
	[cell setPadding:padding];
}
- (CGFloat) padding
{
	return [cell padding];
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
	[super encodeWithCoder:encoder];
	[encoder encodeObject:[cell attributedStringValue] forKey:@"AttributedString"];
	[encoder encodeDouble:(double)[cell padding] forKey:@"Padding"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
	if (nil == (self = [super initWithCoder:decoder]))
	{
		return nil;
	}
	[self createCell];
	[cell setAttributedStringValue:
		[decoder decodeObjectForKey:@"AttributedString"]];
	[cell setPadding:(CGFloat)[decoder decodeDoubleForKey:@"Padding"]];
	return self;
}
- (void)drawRect:(NSRect)rect
{
	[[NSColor whiteColor] setFill];
	[NSBezierPath fillRect:rect];
	[cell drawWithFrame:[self bounds]
				 inView:self];
}
@end

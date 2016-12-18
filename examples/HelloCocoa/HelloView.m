#import "HelloView.h"


@implementation HelloView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	NSString *text = @"Hello World";
	NSMutableAttributedString *str = 
		[[NSMutableAttributedString alloc] initWithString:text];
	NSFont *font = [NSFont fontWithName:@"Times"
								   size:32];
	NSDictionary *attributes = 
		[NSDictionary dictionaryWithObject:font
									forKey:NSFontAttributeName];
	[str setAttributes:attributes
				 range:NSMakeRange(0, [text length])];
	[str drawInRect:rect];
}

@end

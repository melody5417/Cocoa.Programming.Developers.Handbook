#import <InterfaceBuilderKit/InterfaceBuilderKit.h>
#import <CircleText/CircleTextView.h>
#import "CircleTextInspector.h"


@implementation CircleTextView ( CircleTextView )

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths
{
    [super ibPopulateKeyPaths:keyPaths];
	
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObject:@"attributedStringValue"];
}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes 
{
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[CircleTextInspector class]];
}

@end

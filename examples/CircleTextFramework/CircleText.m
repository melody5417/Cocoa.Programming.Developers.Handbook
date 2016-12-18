#import "CircleText.h"
#import "CircleTextView.h"

@implementation CircleText
- (NSArray *)libraryNibNames
{
    return [NSArray arrayWithObject:@"CircleTextLibrary"];
}

- (NSArray *)requiredFrameworks 
{
    return [NSArray arrayWithObject:[NSBundle bundleForClass:[CircleTextView class]]];
}

@end

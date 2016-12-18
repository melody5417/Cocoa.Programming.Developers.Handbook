#import <Foundation/Foundation.h>

@implementation NSUserDefaults (NSURL)
- (void) setURL: (NSURL*)aURL forKey: (NSString*)aKey
{
	[self setObject: [aURL absoluteString] forKey: aKey];
}
- (NSURL*) URLForKey: (NSString*)aKey
{
	return [NSURL URLWithString: [self stringForKey: aKey]];
}
@end

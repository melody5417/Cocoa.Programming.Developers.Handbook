#import <Foundation/Foundation.h>

@interface SimpleObject : NSObject {
	int counter;
}
- (void) addToCounter:(int) anInteger;
- (int) counter;
@end

@implementation SimpleObject
- (void) addToCounter:(int) anInteger
{
	counter += anInteger;
}
- (int) counter
{
	return counter;
}
@end

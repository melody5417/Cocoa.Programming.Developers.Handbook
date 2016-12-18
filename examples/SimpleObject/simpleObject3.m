#import <Foundation/Foundation.h>

@interface SimpleObject : NSObject {
	int counter;
}
- (void) addToCounter:(int) anInteger;
@end
@interface SimpleObject (GetMethod)
- (int) counter;
@end

@implementation SimpleObject
- (void) addToCounter:(int) anInteger
{
	counter += anInteger;
}
@end
@implementation SimpleObject (GetMethod)
- (int) counter
{
	return counter;
}
@end

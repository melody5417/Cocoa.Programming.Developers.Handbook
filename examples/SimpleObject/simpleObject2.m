#import <Foundation/Foundation.h>

@protocol SimpleObject
- (void) addToCounter:(int) anInteger;
- (int) counter;
@end

@interface SimpleObject : NSObject <SimpleObject> {
	int counter;
}
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

int main(void)
{
	[NSAutoreleasePool new];
	id obj = [SimpleObject new];
	if ([obj conformsToProtocol:@protocol(SimpleObject)])
	{
		NSLog(@"obj conforms to the SimpleObject protocol");
	}
	return 0;
}

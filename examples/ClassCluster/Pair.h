#import <Foundation/Foundation.h>

@interface Pair : NSObject {}
- (Pair*) initWithFloat:(float)a float:(float)b;
- (Pair*) initWithInt:(int)a int:(int)b;
- (float) firstFloat;
- (float) secondFloat;
- (int) firstInt;
- (int) secondInt;
@end

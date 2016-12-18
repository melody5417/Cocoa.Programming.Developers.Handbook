#import <Foundation/Foundation.h>

@interface Fibonacci : NSOperation {
	NSUInteger start;
}
- (id) initWithStart:(NSUInteger)i;
- (NSUInteger) result;
- (NSUInteger) fibonacci: (NSUInteger)i;
@end 

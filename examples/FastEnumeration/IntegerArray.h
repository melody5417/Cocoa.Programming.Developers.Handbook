#import <Foundation/Foundation.h>

@interface IntegerArray : NSObject<NSFastEnumeration> {
	NSUInteger count;
	NSInteger *values;
}
- (id)initWithValues: (NSInteger*)array count: (NSUInteger)size;
- (NSInteger)integerAtIndex: (NSUInteger)index;
@end

@interface MutableIntegerArray : IntegerArray {
	unsigned long version;
}
- (void)setInteger: (NSInteger)newValue atIndex: (NSUInteger)index;
@end

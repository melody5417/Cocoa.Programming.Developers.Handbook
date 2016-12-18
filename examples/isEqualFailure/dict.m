#import <Foundation/Foundation.h>

@interface A : NSObject {}
@end
@interface B : A {}
@end
@interface C : A {}
@end
@implementation A
- (id) copyWithZone: (NSZone*)aZone { return [self retain]; }
- (NSString*)description { return [self className]; }
- (NSUInteger)hash { return 0; }
@end
@implementation B
- (BOOL) isEqual: (id)other { return YES; }
@end
@implementation C
- (BOOL) isEqual: (id)other { return NO; }
@end

int main(void)
{
	id pool = [NSAutoreleasePool new];
	NSObject *anObject = [NSObject new];
	NSMutableDictionary *d1 = [NSMutableDictionary new];
	[d1 setObject: anObject forKey: [B new]];
	[d1 setObject: anObject forKey: [C new]];
	NSMutableDictionary *d2 = [NSMutableDictionary new];
	[d2 setObject: anObject forKey: [C new]];
	[d2 setObject: anObject forKey: [B new]];
	NSLog(@"d1: %@", d1);
	NSLog(@"d2: %@", d2);
	return 0;
}


#import <Cocoa/Cocoa.h>

@interface OutlineItem : NSObject<NSCoding>{
	NSString *title;
	NSMutableArray *children;
}
- (NSArray*) allProperties;
@property (retain, nonatomic, readwrite) NSString *title;
@property (retain, nonatomic, readwrite) NSMutableArray *children;
- (void) insertObject:(OutlineItem*)item inChildrenAtIndex:(NSUInteger)index;
- (void) removeObjectFromChildrenAtIndex:(NSUInteger)index;
@end

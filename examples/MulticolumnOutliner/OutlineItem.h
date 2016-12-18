#import <Cocoa/Cocoa.h>

@interface OutlineItem : NSObject<NSCoding>{
	NSMutableDictionary *values;
	NSMutableArray *children;
}
@property (retain, nonatomic, readwrite) NSMutableArray *children;
- (NSArray*) allProperties;
- (void) insertObject:(OutlineItem*)item inChildrenAtIndex:(NSUInteger)index;
- (void) removeObjectFromChildren: (OutlineItem*)child;
@end

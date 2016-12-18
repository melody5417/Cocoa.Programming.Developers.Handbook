#import <Cocoa/Cocoa.h>

@class OutlineDocument;

@interface OutlineViewController : NSObject {
	IBOutlet NSOutlineView *view;
	IBOutlet OutlineDocument *document;
	NSMutableArray *cells;
	NSMutableArray *columns;
}
- (NSUInteger)numberOfColumns;
- (id)typeForColumnAtIndex: (NSUInteger)index;
- (NSString*)titleForColumnAtIndex: (NSUInteger)index;
- (void)setType: (id)aType forColumnAtIndex: (NSUInteger)index;
- (void)setTitle: (NSString*)aTitle forColumnAtIndex: (NSUInteger)index;
- (IBAction)insertChild: (id)sender;
- (IBAction)removeChild: (id)sender;
- (void) addColumn;
- (void) removeColumnAtIndex: (NSUInteger) index;
@end

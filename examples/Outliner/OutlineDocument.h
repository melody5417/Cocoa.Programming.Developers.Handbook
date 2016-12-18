#import <Cocoa/Cocoa.h>
#import "OutlineDataSource.h"

@interface OutlineDocument : NSDocument {
	IBOutlet OutlineDataSource *dataSource;
	IBOutlet NSOutlineView *view;
}
- (IBAction)addItem: (id)sender;
@end

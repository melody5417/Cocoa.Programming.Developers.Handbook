#import <Cocoa/Cocoa.h>
#import "OutlineItem.h"

@class OutlineViewController;

@interface OutlineDocument : NSDocument {
	OutlineItem *root;
	NSMutableArray *columns;
	IBOutlet OutlineViewController *viewController;
}
@property (retain) OutlineItem *root;
@property (readonly) OutlineViewController *viewController;
@end

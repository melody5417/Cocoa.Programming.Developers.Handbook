#import <Cocoa/Cocoa.h>
#import "OutlineItem.h"

@interface OutlineDocument : NSDocument {
	OutlineItem *root;
}
@property (retain) OutlineItem *root;
@end

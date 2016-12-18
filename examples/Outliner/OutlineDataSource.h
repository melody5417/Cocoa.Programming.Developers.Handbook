#import <Cocoa/Cocoa.h>
#import "OutlineItem.h"

@interface OutlineDataSource : NSObject {
	OutlineItem *root;
}
@property (nonatomic, retain) OutlineItem *root;
@end

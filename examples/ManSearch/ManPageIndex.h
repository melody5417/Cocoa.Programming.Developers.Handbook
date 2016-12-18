#import <Cocoa/Cocoa.h>


@interface ManPageIndex : NSObject {
	SKIndexRef index;
}
- (SKIndexRef) searchIndex;
@end

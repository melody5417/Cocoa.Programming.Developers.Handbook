#import <Cocoa/Cocoa.h>
#import "RearrangingScrollView.h"

@interface MoveViewToScrollview : NSObject {
	IBOutlet RearrangingScrollView *view;
}
- (IBAction)MoveViewToScrollview: (id)sender;
@end

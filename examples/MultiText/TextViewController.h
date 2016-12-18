#import <Cocoa/Cocoa.h>


@interface TextViewController : NSObject {
	NSLayoutManager *secondLayout;
	IBOutlet NSSplitView *columnView;
	IBOutlet NSTextView *bottomView;
}
- (IBAction) addColumn:(id)sender;
@end

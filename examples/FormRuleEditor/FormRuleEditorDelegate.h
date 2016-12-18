#import <Cocoa/Cocoa.h>
#import "FormInterface.h"

@interface FormRuleEditorDelegate : NSObject<DynamicForm> {
	IBOutlet NSRuleEditor *view;
	NSMutableArray *items;
}
@end

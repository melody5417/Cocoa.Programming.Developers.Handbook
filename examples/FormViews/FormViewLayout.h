#import <Cocoa/Cocoa.h>
#import "FormInterface.h"
#import "FormView.h"

@interface FormViewLayout : NSObject {
	IBOutlet FormView *view;
	NSMutableArray *controllers;
}
@end

#import "FormInterface.h"
#import <Cocoa/Cocoa.h>

@interface MatrixFormController : NSObject <DynamicForm> {
	IBOutlet NSMatrix *matrix;
	NSMutableArray *results;
}
@end

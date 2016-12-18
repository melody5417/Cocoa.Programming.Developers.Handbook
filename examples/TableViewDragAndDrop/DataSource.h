#import <Cocoa/Cocoa.h>

@interface DataSource : NSObject {
	IBOutlet NSTableView *view;
	IBOutlet NSMutableArray *array;
}
@end

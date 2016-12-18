#import <Cocoa/Cocoa.h>
#import "OutlineViewController.h"

@interface ColumnInspectorController : NSWindowController {
	IBOutlet NSTableView *table;
	IBOutlet NSTableColumn *titleColumn;
}
- (IBAction) addColumn: (id) sender;
- (IBAction) removeColumn: (id) sender;
@end

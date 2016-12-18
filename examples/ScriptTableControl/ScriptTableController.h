#import <Cocoa/Cocoa.h>
#import "ScriptTable.h"

@interface ScriptTableController : NSObject {
	ScriptTableDocument *table;
	IBOutlet NSTextField *rowValue;
	IBOutlet NSTextField *newRowText;
}
- (IBAction)fetchRowValue: (id)sender;
- (IBAction)addRow: (id)sender;
- (IBAction)clearRows: (id)sender;
@end

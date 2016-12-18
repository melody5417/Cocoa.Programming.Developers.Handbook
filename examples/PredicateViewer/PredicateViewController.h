#import <Cocoa/Cocoa.h>

@interface PredicateViewController : NSObject {
	IBOutlet NSPredicateEditor *predicateEditor;
	IBOutlet NSTextField *textField;
	NSPredicate *predicate;
}
- (IBAction)predicateChanged: (id)sender;
- (IBAction)addCompoundRule: (id)sender;
@end

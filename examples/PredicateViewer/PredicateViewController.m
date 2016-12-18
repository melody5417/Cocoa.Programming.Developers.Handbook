#import "PredicateViewController.h"

@implementation PredicateViewController
- (IBAction)predicateChanged: (id)sender
{
	[textField setStringValue: [predicate predicateFormat]];
}
- (IBAction)addCompoundRule: (id)sender
{
	[predicateEditor insertRowAtIndex: 0
							 withType: NSRuleEditorRowTypeCompound
						asSubrowOfRow: -1
							  animate: YES];
}
@end

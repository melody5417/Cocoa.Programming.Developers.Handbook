#import "FormRuleEditorDelegate.h"
#import "FormItemController.h"

@implementation FormRuleEditorDelegate
- (void)awakeFromNib
{
	[view setEditable: NO];
	items = [NSMutableArray new];
}
-      (NSInteger)ruleEditor: (NSRuleEditor*)editor
numberOfChildrenForCriterion: (id)criterion
				 withRowType: (NSRuleEditorRowType)rowType
{
	if (criterion == nil)
	{
		return 1;
	}
	return 0;
}
-         (id)ruleEditor: (NSRuleEditor*)editor
displayValueForCriterion: (id)criterion
				   inRow: (NSInteger)row
{
	return [[items objectAtIndex: row] view];
}
- (id)ruleEditor: (NSRuleEditor*)editor
		   child: (NSInteger)index 
	forCriterion: (id)criterion
	 withRowType: (NSRuleEditorRowType)rowType
{
	return @"";
}
- (void)addRuleWithViewNib: (NSString*)aNib label: (NSString*)aLabel
{
	FormItemController *controller = 
		[[FormItemController alloc] initWithNibName: aNib
											 bundle: [NSBundle mainBundle]];
	controller.label = aLabel;
	[items addObject: controller];
	[view addRow: self];
}
- (void)addTextFieldWithLabel: (NSString*)aLabel
{
	[self addRuleWithViewNib: @"TextFormItem" 
					   label: aLabel];
}
- (void)addBoolFieldWithLabel: (NSString*)aLabel
{
	[self addRuleWithViewNib: @"BoolFormItem" 
					   label: aLabel];
}
- (void)addDateFieldWithLabel: (NSString*)aLabel
{
	[self addRuleWithViewNib: @"DateFormItem" 
					   label: aLabel];
}
- (void)addNumberFieldWithLabel: (NSString*)aLabel
{
	[self addRuleWithViewNib: @"NumberFormItem" 
					   label: aLabel];
}
- (NSArray*)result
{
	NSMutableArray *results = [NSMutableArray array];
	for (NSViewController *controller in items)
	{
		[results addObject: [controller representedObject]];
	}
	NSLog(@"results: %@", results);
	return results;
}
@end

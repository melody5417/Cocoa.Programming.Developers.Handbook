#import "FormViewLayout.h"
#import "FormItemController.h"

@implementation FormViewLayout
- (void)addViewNib: (NSString*)aNib withLabel: (NSString*)aLabel
{
	FormItemController *controller =
	[[FormItemController alloc] initWithNibName: aNib
										 bundle: [NSBundle mainBundle]];
	controller.label = aLabel;
	NSView *subview = [controller view];
	[subview setAutoresizingMask: NSViewMinYMargin | NSViewWidthSizable];
	[view addSubview: subview];
	[controllers addObject: controller];
	[controller release];
	
}
- (void)addTextFieldWithLabel: (NSString*)aLabel
{
	[self addViewNib: @"TextFormItem"
		   withLabel: aLabel];
}
- (void)addBoolFieldWithLabel: (NSString*)aLabel
{
	[self addViewNib: @"BoolFormItem"
		   withLabel: aLabel];
}
- (void)addDateFieldWithLabel: (NSString*)aLabel
{
	[self addViewNib: @"DateFormItem"
		   withLabel: aLabel];
}
- (void)addNumberFieldWithLabel: (NSString*)aLabel
{
	[self addViewNib: @"NumberFormItem"
		   withLabel: aLabel];
}
- (NSArray*)result
{
	NSMutableArray *results = [NSMutableArray array];
	for (NSViewController *controller in controllers)
	{
		[results addObject: [controller representedObject]];
	}
	NSLog(@"results: %@", results);
	return results;
}

@end

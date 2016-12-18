#import "FormTest.h"

@implementation FormTest
- (void)awakeFromNib
{
	[form addTextFieldWithLabel: @"Name:"];
	[form addBoolFieldWithLabel: @"Favourite Boolean:"];
	[form addNumberFieldWithLabel: @"Magic Number:"];
	[form addDateFieldWithLabel: @"Birthday:"];	
}
@end

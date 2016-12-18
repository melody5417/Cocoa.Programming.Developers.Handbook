#import "DecimalValueTransformer.h"

@implementation DecimalValueTransformer
+ (Class)transformedValueClass 
{ 
	return [NSDecimalNumber class];
}
+ (BOOL)allowsReverseTransformation 
{
	return YES;
}
- (id)transformedValue:(id)value
{
	return [value stringValue];
}
- (id)reverseTransformedValue:(id)value
{
	return [NSDecimalNumber decimalNumberWithString:value];
}
@end

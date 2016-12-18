@class NSString;
@class NSArray;
@protocol DynamicForm
- (void)addTextFieldWithLabel: (NSString*)aLabel;
- (void)addBoolFieldWithLabel: (NSString*)aLabel;
- (void)addDateFieldWithLabel: (NSString*)aLabel;
- (void)addNumberFieldWithLabel: (NSString*)aLabel;
- (NSArray*)result;
@end
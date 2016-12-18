#import <Cocoa/Cocoa.h>

@interface NSObject (HTMLFormHandler)
- (void)formSubmitted;
@end

@interface FormPolicyDelegate : NSObject {
	IBOutlet id delegate;
}
@end

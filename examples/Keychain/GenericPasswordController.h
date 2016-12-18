#import <Cocoa/Cocoa.h>


@interface GenericPasswordController : NSObject {
	IBOutlet NSTextField *account;
	IBOutlet NSTextField *service;
	IBOutlet NSTextField *password;
}
- (IBAction) storePassword: (id)sender;
- (IBAction) findPassword: (id)sender;
@end

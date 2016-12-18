#import "GenericPasswordController.h"
#import "Keychain.h"

@implementation GenericPasswordController
- (IBAction) storePassword: (id)sender
{
	Keychain *keychain = [Keychain standardKeychain];
	[keychain setGenericPassword: [password stringValue]
					  forAccount: [account stringValue]
						 service: [service stringValue]];
}
- (IBAction) findPassword: (id)sender
{
	Keychain *keychain = [Keychain standardKeychain];
	NSString *pass = 
		[keychain genericPasswordForAccount: [account stringValue]
									Service: [service stringValue]];
	[password setStringValue: pass];	
}
@end

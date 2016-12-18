#import <Foundation/Foundation.h>

@interface Keychain : NSObject {
	SecKeychainRef keychain;
}
+ (Keychain*) standardKeychain;
+ (Keychain*) keychainWithKeychainRef: (SecKeychainRef)aKeychain;
- (BOOL) setGenericPassword: (NSString*)aPassword
				 forAccount: (NSString*)anAccount
				   	service: (NSString*)aService;
- (NSString*) genericPasswordForAccount: (NSString*)anAccount
								Service:(NSString*)aService;
- (BOOL) setInternetPassword: (NSString*)aPassword
				  forAccount: (NSString*)anAccount
			inSecurityDomain: (NSString*)aDomain
				    onServer: (NSString*)aServer
						port: (UInt16)aPort
					protocol: (SecProtocolType) aProtocol
						path: (NSString*)aPath;
- (BOOL) setInternetPassword: (NSString*)aPassword
				  forAccount: (NSString*)anAccount
			inSecurityDomain: (NSString*)aDomain
				    onServer: (NSString*)aServer
						port: (UInt16)aPort
					protocol: (SecProtocolType) aProtocol
						path: (NSString*)aPath;
- (NSString*) internetPasswordForAccount: (NSString*)anAccount
						inSecurityDomain: (NSString*)aDomain
								onServer: (NSString*)aServer
									port: (UInt16)aPort
								protocol: (SecProtocolType) aProtocol
									path: (NSString*)aPath;
@end

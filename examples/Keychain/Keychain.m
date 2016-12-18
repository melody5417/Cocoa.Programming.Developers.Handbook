#import "Keychain.h"
#import <Security/Security.h>

static Keychain *defaultKeychain;

@implementation Keychain
+ (void) initialize
{
	if (self == [Keychain class])
	{
		defaultKeychain = [[Keychain alloc] init];
	}
}
+ (Keychain*) standardKeychain
{
	return defaultKeychain;
}
- (Keychain*) initWithKeychainRef: (SecKeychainRef)aKeychain
{
	if (nil == (self = [self init])) { return nil; }
	keychain = (SecKeychainRef)CFRetain(aKeychain);
	return self;
}
+ (Keychain*) keychainWithKeychainRef: (SecKeychainRef)aKeychain
{
	return [[[self alloc] initWithKeychainRef:aKeychain] autorelease];
}
- (void) finalize
{
	CFRelease(keychain);
}
- (void) dealloc
{
	CFRelease(keychain);
	[super dealloc];
}
- (BOOL) setGenericPassword: (NSString*)aPassword
				 forAccount: (NSString*)anAccount
				   	service: (NSString*)aService
{
	SecKeychainItemRef item = NULL;
	SecKeychainFindGenericPassword(keychain,
		[aService lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		[aService UTF8String],
		[anAccount lengthOfBytesUsingEncoding: NSUTF8StringEncoding], 
		[anAccount UTF8String],
		NULL,
		NULL,
		&item);
	OSStatus result;
	if (item != NULL)
	{
		result = SecKeychainItemModifyAttributesAndData(
			item,
			NULL,
			[aPassword lengthOfBytesUsingEncoding: NSUTF8StringEncoding], 
			[aPassword UTF8String]);
		CFRelease(item);
	}
	else
	{	
		result = SecKeychainAddGenericPassword(keychain,
			[aService lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		    [aService UTF8String],
		    [anAccount lengthOfBytesUsingEncoding: NSUTF8StringEncoding], 
		    [anAccount UTF8String],
		    [aPassword lengthOfBytesUsingEncoding: NSUTF8StringEncoding], 
		    [aPassword UTF8String],
		    NULL);
	}
	return (result == noErr);
}
- (NSString*) genericPasswordForAccount: (NSString*)anAccount
								Service:(NSString*)aService
{
	UInt32 length;
	void *password;
	OSStatus result = SecKeychainFindGenericPassword(keychain,
			[aService lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		    [aService UTF8String],
		    [anAccount lengthOfBytesUsingEncoding: NSUTF8StringEncoding], 
		    [anAccount UTF8String],
			&length,
			&password,
			NULL);
	if (result != noErr) { return nil; }
	NSString *passwordString = 
		[[NSString alloc] initWithBytes: password
								 length: length
							   encoding: NSUTF8StringEncoding];
	SecKeychainItemFreeContent(NULL, password);
	return [passwordString autorelease];
}
- (BOOL) setInternetPassword: (NSString*)aPassword
				  forAccount: (NSString*)anAccount
			inSecurityDomain: (NSString*)aDomain
				    onServer: (NSString*)aServer
						port: (UInt16)aPort
					protocol: (SecProtocolType) aProtocol
						path: (NSString*)aPath
{
	SecKeychainItemRef item = NULL;
	SecKeychainFindInternetPassword(keychain,
		[aServer lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		[aServer UTF8String],
		[aDomain lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		[aDomain UTF8String],
		[anAccount lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		[anAccount UTF8String],
		[aPath lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
		[aPath UTF8String],
		aPort,
		aProtocol,
		kSecAuthenticationTypeDefault,
		NULL,
		NULL,
		&item);
	OSStatus result;
	if (item != NULL)
	{
		result = SecKeychainItemModifyAttributesAndData(
			item,
			NULL,
			[aPassword lengthOfBytesUsingEncoding: NSUTF8StringEncoding], 
			[aPassword UTF8String]);
		CFRelease(item);
	}
	else
	{			
		result = SecKeychainAddInternetPassword(keychain,
			[aServer lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aServer UTF8String],
			[aDomain lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aDomain UTF8String],
			[anAccount lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[anAccount UTF8String],
			[aPath lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aPath UTF8String],
			aPort,
			aProtocol,
			kSecAuthenticationTypeDefault,
			[aPassword lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aPassword UTF8String],
			NULL);
	}
	return (result == noErr);
}
- (NSString*) internetPasswordForAccount: (NSString*)anAccount
						inSecurityDomain: (NSString*)aDomain
								onServer: (NSString*)aServer
									port: (UInt16)aPort
								protocol: (SecProtocolType) aProtocol
									path: (NSString*)aPath
{
	UInt32 length;
	void *password;
	OSStatus result = SecKeychainFindInternetPassword(keychain,
			[aServer lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aServer UTF8String],
			[aDomain lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aDomain UTF8String],
			[anAccount lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[anAccount UTF8String],
			[aPath lengthOfBytesUsingEncoding: NSUTF8StringEncoding],
			[aPath UTF8String],
			aPort,
			aProtocol,
			kSecAuthenticationTypeDefault,
			&length,
			&password,
			NULL);
	if (result != noErr) { return nil; }
	NSString *passwordString = 
		[[NSString alloc] initWithBytes: password
								 length: length
							   encoding: NSUTF8StringEncoding];
	SecKeychainItemFreeContent(NULL, password);
	return [passwordString autorelease];
}
@end

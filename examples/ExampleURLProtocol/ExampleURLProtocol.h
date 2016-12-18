#import <Cocoa/Cocoa.h>

@interface ExampleURLProtocol : NSURLProtocol
+ (BOOL) setString: (NSString*)aString forURL: (NSURL*)aURL;
@end

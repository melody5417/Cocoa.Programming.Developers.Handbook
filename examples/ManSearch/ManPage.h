#import <Cocoa/Cocoa.h>

@interface ManPage : NSObject {
	NSString *path;
	NSString *contents;
}
+ (ManPage*)manPageWithPath: (NSString*)aPath;
- (NSURL*)URL;
- (NSString*)stringValue;
@end

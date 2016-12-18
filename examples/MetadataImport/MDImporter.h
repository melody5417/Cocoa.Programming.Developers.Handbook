#import <Cocoa/Cocoa.h>

@interface MDImporter : NSObject {

}
- (BOOL) getAttributes: (NSMutableDictionary*)attributes
		forFileWithUTI: (NSString*)aUTI
				atPath: (NSString*)aPath;
@end

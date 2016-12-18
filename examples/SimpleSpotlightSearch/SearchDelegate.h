#import <Cocoa/Cocoa.h>

@interface SearchDelegate : NSObject {
	NSMetadataQuery *query;
}
- (IBAction)runQuery: (id)sender;
@end

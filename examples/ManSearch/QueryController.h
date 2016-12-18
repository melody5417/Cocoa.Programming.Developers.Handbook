#import <Cocoa/Cocoa.h>

@interface QueryController : NSObject {
	SKSearchRef query;
	NSTimer *poll;
	IBOutlet id index;
	float maxScore;
	NSMutableArray *results;
}
- (void)runQuery: (NSString*)queryString;
- (IBAction)runQueryFrom: (id)sender;
@end

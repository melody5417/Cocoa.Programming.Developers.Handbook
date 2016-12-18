#import <Cocoa/Cocoa.h>

@interface MessageSender : NSObject {
	NSMutableArray *peers;
}
- (IBAction) sendMessage:(id)sender;
@end

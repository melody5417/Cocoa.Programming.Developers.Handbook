#import <Cocoa/Cocoa.h>

@interface MessageReceiver : NSObject {
	NSMutableArray *messages;
	NSString *name;
}
- (void) handleMessage:(NSString*)aMessage
				  from:(NSString*)aUser;
- (NSString*) name;
@end

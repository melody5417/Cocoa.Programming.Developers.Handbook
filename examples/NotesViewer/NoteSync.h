#import <Cocoa/Cocoa.h>
#import "SyncClient.h"

@interface NoteSync : NSObject {
	SyncClient *client;
	ISyncSessionDriver *driver;
	NSArray *notes;
}
@property (nonatomic, copy) NSArray *notes;
@end

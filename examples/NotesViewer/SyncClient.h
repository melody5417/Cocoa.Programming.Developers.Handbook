#import <Cocoa/Cocoa.h>
#import <SyncServices/SyncServices.h>

@interface SyncClient : NSObject<ISyncSessionDriverDataSource> {
	NSMutableDictionary *notes;
}
@property (readonly) NSMutableDictionary *notes;
@end

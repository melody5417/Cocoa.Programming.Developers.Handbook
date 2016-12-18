#import "NoteSync.h"

@implementation NoteSync
@synthesize notes;
- (void)awakeFromNib
{
	client = [SyncClient new];
	driver = 
		[ISyncSessionDriver sessionDriverWithDataSource: client];
	[driver sync];
	[client addObserver: self
			 forKeyPath: @"notes"
				options: NSKeyValueObservingOptionNew
				context: NULL];
	self.notes = [client.notes allValues];
}
- (void)observeValueForKeyPath: (NSString*)keyPath
					  ofObject: (id)object
                        change: (NSDictionary*)change
                       context: (void*)context
{
	self.notes = [client.notes allValues];
}
@end

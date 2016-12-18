#import "SyncClient.h"

@implementation SyncClient
@synthesize notes;
- (id)init
{
	if (nil == (self = [super init])) { return nil; }
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	notes = [[defaults dictionaryForKey: @"CachedNotes"] mutableCopy];
	if (nil == notes)
	{
		notes = [NSMutableDictionary new];
	}
	return self;
}
- (NSString*)clientIdentifier
{
    return @"com.example.NoteViewer";
}
- (NSURL*)clientDescriptionURL
{
	NSString *path = 
		[[NSBundle mainBundle] pathForResource:@"ClientDescription"
										ofType:@"plist"];
	return [NSURL fileURLWithPath: path];
}
- (NSArray*)schemaBundleURLs
{
	return [NSArray arrayWithObject: [NSURL fileURLWithPath: 
		@"/System/Library/SyncServices/Schemas/Notes.syncschema"]];
}
- (NSArray*)entityNamesToSync
{
	return [NSArray arrayWithObject: @"com.apple.notes.Note"];
}
- (ISyncSessionDriverChangeResult)applyChange: (ISyncChange*)change
                                forEntityName: (NSString*)entityName
                     remappedRecordIdentifier: (NSString**)outRecordIdentifier
                              formattedRecord: (NSDictionary**)outRecord
                                        error: (NSError**)outError
{
	[self willChangeValueForKey: @"notes"];
	if ([change type] == ISyncChangeTypeDelete)
	{
		[notes removeObjectForKey: [change recordIdentifier]];
    }
    else
	{
		[notes setObject: [change record]
				  forKey: [change recordIdentifier]];
    }
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: notes
				 forKey: @"CachedNotes"];
	[self didChangeValueForKey: @"notes"];
    return ISyncSessionDriverChangeAccepted;
	
}
- (BOOL)deleteAllRecordsForEntityName:(NSString *)entityName error:(NSError **)outError
{
	return NO;
}
- (NSDictionary*)recordsForEntityName: (NSString*)entityName
						   moreComing: (BOOL*)moreComing
								error: (NSError**)outError
{
	*moreComing = NO;
	return notes;
}
- (ISyncSessionDriverMode)preferredSyncModeForEntityName: (NSString*)entity
{
	return ISyncSessionDriverModeSlow;
}
@end

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSPersistentStore (EditMetadata)
+ (BOOL) setMetadataValue:(id)aValue
			   forKeyPath:(NSString*)keyPath
   inPersistentStoreAtURL:(NSURL*)anURL;
@end

@implementation NSPersistentStore (EditMetadata)
+ (BOOL) setMetadataValue:(id)aValue
			   forKeyPath:(NSString*)keyPath
   inPersistentStoreAtURL:(NSURL*)anURL
{
	NSMutableDictionary *dict = 
		[[self metadataForPersistentStoreWithURL: anURL
										   error: NULL] mutableCopy];
	if (nil == dict)
	{
		return NO;
	}
	[dict setValue: aValue forKeyPath: keyPath];
	return  [self setMetadata: dict
	forPersistentStoreWithURL: anURL
	                    error: NULL];
	
}
@end
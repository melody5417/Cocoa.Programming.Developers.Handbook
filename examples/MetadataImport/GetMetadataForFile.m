#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h> 

#import "MDImporter.h"

Boolean GetMetadataForFile(void* thisInterface, 
			   CFMutableDictionaryRef attributes, 
			   CFStringRef contentTypeUTI,
			   CFStringRef pathToFile)
{
	id pool = [NSAutoreleasePool new];
	MDImporter *import = [[MDImporter alloc] init];
	Boolean success = [import getAttributes: (id)attributes
							 forFileWithUTI: (id)contentTypeUTI
									 atPath: (id)pathToFile];
	[import release];
	[pool release];
	return success;
}

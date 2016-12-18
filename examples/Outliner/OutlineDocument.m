#import "OutlineDocument.h"

@implementation OutlineDocument

- (id)init
{
    if (nil == (self = [super init]))
	{
		return nil;
    }
	return self;
}

- (NSString *)windowNibName
{
    return @"OutlineDocument";
}


- (NSData *)dataOfType: (NSString*)typeName
                 error: (NSError**)outError
{
    if (NULL != outError)
	{
		*outError = [NSError errorWithDomain: NSOSStatusErrorDomain
		                                code: unimpErr
		                            userInfo: nil];
	}
	return nil;
}

- (BOOL)readFromData: (NSData*)data
              ofType: (NSString*)typeName
               error: (NSError**)outError
{
    if (NULL != outError)
	{
		*outError = [NSError errorWithDomain: NSOSStatusErrorDomain
		                                code: unimpErr
		                            userInfo: nil];
	}
    return YES;
}
- (IBAction) addItem: (id)sender
{
	OutlineItem *item = [view itemAtRow: [view selectedRow]];
	if (nil == item)
	{
		item = dataSource.root;
	}
	[item.children addObject: [OutlineItem new]];
	[view reloadItem: item];
}
@end

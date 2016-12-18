#import "OutlineDocument.h"
#import "OutlineItemDictionaryTransformer.h"

@implementation OutlineDocument
@synthesize root;

- (id)initWithType: (NSString*)typeName error: (NSError**)outError
{
    if (nil == (self = [self init]))
	{
		return nil;
    }
	root = [OutlineItem new];
	return self;
}

- (NSString*)windowNibName
{
    return @"OutlineDocument";
}


- (NSData*)dataOfType: (NSString*)typeName
                error: (NSError**)outError
{
	if ([@"XMLPropertyList" isEqualToString: typeName])
	{
		NSDictionary *dict = [OutlineItemDictionaryTransformer
			dictionaryForOutlineItem:root];
		return [NSPropertyListSerialization 
			dataFromPropertyList: dict
			              format: NSPropertyListXMLFormat_v1_0
			    errorDescription: NULL];
	}
	if ([@"Outline" isEqualToString:typeName])
	{
		return [NSKeyedArchiver archivedDataWithRootObject: root];
	}
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
	if ([@"XMLPropertyList" isEqualToString: typeName])
	{
		NSDictionary *dict = [NSPropertyListSerialization
			propertyListFromData: data
			    mutabilityOption: NSPropertyListMutableContainersAndLeaves
						  format: NULL
				errorDescription: NULL];
		root = [OutlineItemDictionaryTransformer outlineItemFromDictionary:dict];
	}
	else if ([@"Outline" isEqualToString: typeName])
	{
		root = [NSKeyedUnarchiver unarchiveObjectWithData: data];
	}	
	root = [root retain];
    if (nil == root && NULL != outError)
	{
		*outError = [NSError errorWithDomain: NSOSStatusErrorDomain
		                                code: unimpErr
		                            userInfo: nil];
		return NO;
	}
    return YES;
}
- (void) dealloc
{
	[root release];
	[super dealloc];
}
@end

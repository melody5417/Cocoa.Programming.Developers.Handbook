#import "OutlineDocument.h"
#import "OutlineItemDictionaryTransformer.h"

@implementation OutlineDocument
@synthesize root;

- (void) registerObserversForOutlineItem: (OutlineItem*)item
{
	[item addObserver: self
	       forKeyPath: @"children" 
	          options: NSKeyValueObservingOptionOld |
	                   NSKeyValueObservingOptionNew
	          context: nil];
	NSArray *properties = [item allProperties];
	for (id key in properties)
	{
		[item addObserver: self
		       forKeyPath: key
		          options: NSKeyValueObservingOptionOld |
		                   NSKeyValueObservingOptionNew
		          context: nil];
	}
}
- (void) unregisterObserversForOutlineItem: (OutlineItem*)item
{
	[item removeObserver: self
			  forKeyPath: @"children"];
	NSArray *properties = [item allProperties];
	for (id key in properties)
	{
		[item removeObserver: self
		          forKeyPath: key];
	}
}
- (void) registerObserversForItemTree: (OutlineItem*)item
{
	[self registerObserversForOutlineItem: item];
	for (OutlineItem *child in item.children)
	{
		[self registerObserversForItemTree: child];
	}
}
- (void) unregisterObserversForItemTree: (OutlineItem*)item
{
	[self unregisterObserversForOutlineItem: item];
	for (OutlineItem *child in item.children)
	{
		[self unregisterObserversForItemTree: child];
	}
}

- (id)initWithType: (NSString*)typeName error: (NSError**)outError
{
    if (nil == (self = [self init]))
	{
		return nil;
	}
	root = [OutlineItem new];
	[self registerObserversForOutlineItem: root];
	return self;
}
- (void)observeValueForKeyPath: (NSString*)keyPath
                      ofObject: (OutlineItem*)object
                        change: (NSDictionary*)change
                       context: (void*)context
{
	if (![object isKindOfClass: [OutlineItem class]]) return;
	NSUndoManager *undo = [self undoManager];
	// Find the type of the change
	switch ([[change objectForKey: NSKeyValueChangeKindKey] intValue])
	{
		// Handle property changes
		case NSKeyValueChangeSetting:
		{
			id old = [change objectForKey: NSKeyValueChangeOldKey];
			// Construct the inverse invocation
			NSMethodSignature *sig = [object methodSignatureForSelector: @selector(setValue:forKeyPath:)];
			NSInvocation *inv = [NSInvocation invocationWithMethodSignature: sig];
			[inv setSelector: @selector(setValue:forKeyPath:)];
			[inv setArgument: &old atIndex: 2];
			[inv setArgument: &keyPath atIndex: 3];
			// Register it with the undo manager
			[[undo prepareWithInvocationTarget: object] forwardInvocation: inv];
			[undo setActionName: @"Typing"];
			break;
		}
		// Handle child insertion
		case NSKeyValueChangeInsertion:
		{
			NSArray *new = [change objectForKey: NSKeyValueChangeNewKey];
			for (OutlineItem *child in new)
			{
				[self registerObserversForItemTree: child];
			}
			NSIndexSet *changedIndexes = 
			[change objectForKey: NSKeyValueChangeIndexesKey];
			NSUInteger count = [changedIndexes count];
			NSUInteger indexes[count];
			NSRange range = NSMakeRange(0, [changedIndexes lastIndex]+1);
			[changedIndexes getIndexes: indexes
			                  maxCount: count
			              inIndexRange: &range];
			for(NSUInteger i=0; i<count; i++)
			{
				[undo registerUndoWithTarget: object 
				                    selector: @selector(willChangeValueForKey:) 
				                      object: @"children"];
				[[undo prepareWithInvocationTarget: object] 
				   removeObjectFromChildrenAtIndex: indexes[i]];
				[undo registerUndoWithTarget: object
				                    selector: @selector(didChangeValueForKey:) 
				                      object: @"children"];
			}
			[undo setActionName: @"Add Item"];
			break;
		}
		// Handle child removal
		case NSKeyValueChangeRemoval:
		{
			NSArray *old = [change objectForKey: NSKeyValueChangeOldKey];
			
			NSIndexSet *changedIndexes = 
				[change objectForKey: NSKeyValueChangeIndexesKey];
			NSUInteger count = [changedIndexes count];
			NSUInteger indexes[count];
			NSRange range = NSMakeRange(0, [changedIndexes lastIndex]+1);
			[changedIndexes getIndexes: indexes
			                  maxCount: count
			              inIndexRange: &range];
			for(NSUInteger i=0; i<count; i++)
			{
				OutlineItem *child = [old objectAtIndex: i];
				[self unregisterObserversForItemTree: child];
				id proxy = [undo prepareWithInvocationTarget: object];
				[proxy insertObject: child 
				  inChildrenAtIndex: indexes[i]];
			}
			[undo setActionName: @"Remove Item"];
			break;
		}
	}
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
		NSDictionary *dict =
			[OutlineItemDictionaryTransformer dictionaryForOutlineItem: root];
		return [NSPropertyListSerialization dataFromPropertyList: dict
												          format: NSPropertyListXMLFormat_v1_0
	                                            errorDescription: NULL];
	}
	if ([@"Outline" isEqualToString: typeName])
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
		root = [OutlineItemDictionaryTransformer outlineItemFromDictionary: dict];
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
	[self registerObserversForItemTree: root];
    return YES;
}
_ (void) finalize
{
	[self unregisterObserversForOutlineItem: root];
}
- (void) dealloc
{
	[self finalize];
	[root release];
	[super dealloc];
}
@end

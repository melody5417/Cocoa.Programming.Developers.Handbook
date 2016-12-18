#import "TableModel.h"

@interface TableItem : NSObject {
	id container;
	NSString *string;
}
+ (TableItem*)itemWithString: (NSString*)aString;
- (void)setContainer: (id)aTable;
@end
@implementation TableItem
- (TableItem*)initWithString: (NSString*)aString
{
	if (nil == (self = [self init])) { return nil; }
	string = [aString retain];
	return self;
}
+ (TableItem*)itemWithString: (NSString*)aString
{
	return [[[self alloc] initWithString: aString] autorelease];
}
- (void)setContainer: (id)aTable
{
	container = aTable;
}
- (void)dealloc
{
	[string release];
	[super dealloc];
}
- (NSScriptObjectSpecifier*)objectSpecifier
{
	NSScriptObjectSpecifier *parent = [container objectSpecifier];
	NSUInteger index = [[container valueForKey: @"items"] indexOfObjectIdenticalTo: self];
	id a= [[[NSIndexSpecifier alloc]
		 initWithContainerClassDescription: [parent keyClassDescription]
						containerSpecifier: parent
									   key: @"items"
									 index: index] autorelease];
	return a;
}
@end



@implementation TableModel
- (void)awakeFromNib
{
	items = [NSMutableArray new];
	TableItem *placeholder = [TableItem itemWithString: @"foo"];
	[placeholder setContainer: self];
	[self willChangeValueForKey: @"items"];
	[items addObject: placeholder];
	[self didChangeValueForKey: @"items"];
}
- (void)handleClearScriptCommand: (NSScriptCommand*)aCommand
{
	[self willChangeValueForKey: @"items"];
	[items removeAllObjects];
	[self didChangeValueForKey: @"items"];
}
- (void)handleAddScriptCommand: (NSScriptCommand*)aCommand
{
	NSString * newEntry = 
		[[aCommand evaluatedArguments] objectForKey: @"entry"];
	TableItem *newItem = [TableItem itemWithString: newEntry];
	[newItem setContainer: self];
	[self willChangeValueForKey: @"items"];
	[items addObject: newItem];
	[self didChangeValueForKey: @"items"];
}
- (NSScriptObjectSpecifier*)objectSpecifier
{
	NSScriptClassDescription *parent = 
		[NSScriptClassDescription classDescriptionForClass: [NSApp class]];
	return [[[NSIndexSpecifier alloc]
		 initWithContainerClassDescription: parent
						containerSpecifier: nil
									   key: @"orderedDocuments"
							         index: 0] autorelease];
}
@end

#import "OutlineItemDictionaryTransformer.h"


@implementation OutlineItemDictionaryTransformer
+ (NSDictionary*) dictionaryForOutlineItem:(OutlineItem*)item
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	NSArray *properties = [[item classDescription] attributeKeys];
	for (NSString *property in properties)
	{
		[dict setObject:[item valueForKey:property]
		         forKey:property];
	}
	NSArray *children = [item children];
	NSMutableArray *childDictionaries =
	   	[NSMutableArray array];
	for (id child in children)
	{
		[childDictionaries addObject:[self dictionaryForOutlineItem:child]];
	}
	[dict setObject:childDictionaries forKey:@"children"];
	return dict;
}
+ (OutlineItem*) outlineItemFromDictionary:(NSDictionary*)dict
{
	OutlineItem *item = [[[OutlineItem alloc] init] autorelease];
	NSArray *keys = [dict allKeys];
	for (NSString *key in keys)
	{
		if ([@"children" isEqualToString:key])
		{
			NSArray *childDictionaries = [dict objectForKey:key];
			for (id child in childDictionaries)
			{
				[item.children addObject:[self outlineItemFromDictionary:child]];
			}
		}
		else
		{
			[item setValue:[dict objectForKey:key]
			        forKey:key];
		}
	}
	return item;
}
@end

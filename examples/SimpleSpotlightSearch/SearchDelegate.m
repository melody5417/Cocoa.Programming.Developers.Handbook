#import "SearchDelegate.h"

@implementation SearchDelegate
- (IBAction)runQuery: (id)sender
{
	if (nil == query)
	{
		[self willChangeValueForKey: @"query"];
		query = [NSMetadataQuery new];
		[self didChangeValueForKey: @"query"];
	}
	else
	{
		[query stopQuery];
	}
	NSPredicate *predicate = 
		[NSPredicate predicateWithFormat: @"kMDItemTextContent LIKE %@",
			[sender stringValue]];
	[query setPredicate: predicate];
	[query startQuery];
}
@end

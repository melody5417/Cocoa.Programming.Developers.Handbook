#import "QueryController.h"
#import "ManPageIndex.h"

@implementation QueryController
- (void)awakeFromNib
{
	results = [NSMutableArray new];
}
- (void)dealloc
{
	if (NULL != query)
	{
		SKSearchCancel(query);
		CFRelease(query);
	}
	[results release];
	[poll invalidate];
	[poll release];
	[super dealloc];
}
- (IBAction)runQueryFrom: (id)sender;
{
	[self runQuery: [sender stringValue]];
}
- (IBAction)runQuery: (NSString*)queryString;
{
	if (NULL != query)
	{
		SKSearchCancel(query);
		CFRelease(query);
	}
	[self willChangeValueForKey: @"results"];
	[results removeAllObjects];
	[self didChangeValueForKey: @"results"];
	
	SKIndexRef idx = [index searchIndex];
	SKIndexFlush(idx);
	query = SKSearchCreate(idx,
						   (CFStringRef)queryString,
						   kSKSearchOptionDefault);
	[poll release];
	maxScore = 0;
	poll = [[NSTimer scheduledTimerWithTimeInterval: 1
											 target: self
										   selector: @selector(updateResults:)
										   userInfo: nil
											repeats: YES] retain];
}
- (void) updateResults: (id)sender
{
	SKDocumentID ids[20];
	float scores[20];
	CFIndex found = 0;
	Boolean more = SKSearchFindMatches(query, 20, ids, scores, 0, &found);
	if (!more)
	{
		[poll invalidate];
		[poll release];
		poll = nil;
		CFRelease(query);
		query = NULL;
	}
	if (found > 0)
	{
		[self willChangeValueForKey: @"results"];
		for (NSUInteger i=0 ; i<found ; i++)
		{
			SKDocumentRef ref = SKIndexCopyDocumentForDocumentID(
				[index searchIndex], ids[i]);																 
			NSURL *url = (NSURL*)SKDocumentCopyURL(ref);
			CFRelease(ref);
			NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
				[NSNumber numberWithFloat: scores[i]], @"score",
				[url autorelease], @"URL",
				[[url path] lastPathComponent], @"name",
				nil];
			[results addObject: result];
			if (scores[i] > maxScore)
			{
				[self willChangeValueForKey: @"maxScore"];
				maxScore = scores[i];
				[self didChangeValueForKey: @"maxScore"];
			}
		}
		[self didChangeValueForKey: @"results"];
	}
}
@end

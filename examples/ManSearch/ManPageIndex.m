#import "ManPageIndex.h"
#import "ManPage.h"

@interface ManPageIndex (IndexingThread)
- (void)buildIndex;
- (void)indexManAtPath: (NSString*)path;
@end

@implementation ManPageIndex (IndexingThread)
- (void)buildIndex
{
	[self retain];
	[NSThread detachNewThreadSelector: @selector(buildIndexInThread)
							 toTarget: self
						   withObject: nil];
}
- (void)buildIndexInThread
{
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	NSDate *start = [NSDate date];
	NSFileManager *fm = [NSFileManager defaultManager];
	for (NSString *dir in [fm directoryContentsAtPath: @"/usr/share/man"])
	{
		BOOL isDir = NO;
		NSString *manPath = [@"/usr/share/man" stringByAppendingPathComponent: dir];
		if ([fm fileExistsAtPath: manPath isDirectory: &isDir] && isDir)
		{
			for (NSString *file in [fm directoryContentsAtPath: manPath])
			{
				NSString *manFile = [manPath stringByAppendingPathComponent: file];
				if ([fm fileExistsAtPath: manFile isDirectory: &isDir] && !isDir)
				{
					[self indexManAtPath: manFile];
				}
			}
		}
	}
	NSLog(@"Indexing took %d seconds", 0-(int)[start timeIntervalSinceNow]); 
	[pool release];
	[self release];
}
- (void)indexManAtPath: (NSString*)path
{
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	ManPage *page = [ManPage manPageWithPath: path];
	CFURLRef url = (CFURLRef)[page URL];
	CFStringRef text = (CFStringRef)[page stringValue];
	SKDocumentRef doc = SKDocumentCreateWithURL(url);
	SKIndexAddDocumentWithText(index, doc, text, YES);
	[pool release];
}
@end


@implementation ManPageIndex
- (void) awakeFromNib
{
	NSSet *stopWords = [NSSet setWithObjects: 
		@"NAME", @"SYNOPSIS", @"DESCRIPTION",
		@"EXAMPLES", @"DIAGNOSTICS", @"ENVIRONMENT",
		@"COMPATIBILITY", @"STANDARDS", @"HISTORY",
		@"BUGS", nil];
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSNumber numberWithInt: 4], kSKMinTermLength,
		stopWords, kSKStopWords,
		[NSNumber numberWithBool: YES], kSKProximityIndexing,
		nil];
	index = SKIndexCreateWithMutableData((CFMutableDataRef)[NSMutableData data],
										 (CFStringRef)@"Man page index",
										 kSKIndexInverted,
										 (CFDictionaryRef)attributes);
	[self buildIndex];
}
- (SKIndexRef) searchIndex
{
	return index;
}
- (void) dealloc
{
	CFRelease(index);
	[super dealloc];
}
@end

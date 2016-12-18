#import "ManPage.h"

@implementation ManPage
- (id) initWithPath: (NSString*)aPath
{
	if (nil == (self = [self init])) { return nil; }
	path = [aPath retain];
	return self;
}
+ (ManPage*)manPageWithPath: (NSString*)aPath
{
	return [[[self alloc] initWithPath: aPath] autorelease];
}
- (void)dealloc
{
	[path release];
	[contents release];
	[super dealloc];
}
- (NSURL*)URL
{
	return [[[NSURL alloc] initFileURLWithPath: path] autorelease];
}
- (NSString*)stringValue
{
	if (contents == nil)
	{
		id file = [NSFileHandle fileHandleForReadingAtPath: path];
		if ([[path pathExtension] isEqualToString:@"gz"])
		{
			NSPipe *decompressed = [NSPipe pipe];
			NSTask *gzcat = [[NSTask alloc] init];
			[gzcat setLaunchPath: @"/usr/bin/gzcat"];
			[gzcat setStandardInput: file];
			[gzcat setStandardOutput: decompressed];
			file = decompressed;
			[gzcat launch];
			[gzcat autorelease];
		}
		NSPipe *formatted = [NSPipe pipe];
		NSTask *groff = [[NSTask alloc] init];
		[groff setLaunchPath: @"/usr/bin/groff"];
		[groff setCurrentDirectoryPath: [path stringByDeletingLastPathComponent]];
		[groff setStandardInput: file];
		[groff setStandardError: [NSFileHandle fileHandleWithNullDevice]];
		[groff setStandardOutput: formatted];
		[groff setArguments: [NSArray arrayWithObjects: 
			@"-Tutf8", @"-man", @"-P", @"-b", @"-P", @"-c",
			@"-P", @"-d", @"-P", @"-u", nil]];
		[groff launch];
		NSData *pageData = [[formatted fileHandleForReading] readDataToEndOfFile];
		[groff waitUntilExit];
		[groff release];
		contents = [[NSString alloc] initWithData: pageData
										 encoding: NSUTF8StringEncoding];
	}
	return contents;
}
@end

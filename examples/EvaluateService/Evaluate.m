#import "Evaluate.h"


@implementation Evaluate
- (void)evaluate: (NSPasteboard*)pboard
        userData: (NSString*)userData
           error: (NSString**)error
{
    NSArray *types = [pboard types];
    if (![types containsObject: NSStringPboardType]) 
	{
		if (error != NULL)
		{
			*error = @"Invalid pasteboard type";
		}
        return;
    }
	NSString *equation = [pboard stringForType: NSStringPboardType];
	
	NSTask *bc = [NSTask new];
	[bc setLaunchPath: @"/usr/bin/bc"];
	[bc setArguments: [NSArray arrayWithObject: @"-q"]];
	NSPipe *input = [NSPipe pipe];
	NSPipe *result = [NSPipe pipe];
	[bc setStandardInput: input];
	[bc setStandardOutput: result];
	[bc launch];
	
	NSData *data = [[equation stringByAppendingString:@"\n"]
			  dataUsingEncoding: NSUTF8StringEncoding];
	[[input fileHandleForWriting] writeData: data];
	[[input fileHandleForWriting] closeFile];
	data = [[result fileHandleForReading] readDataToEndOfFile];
	[bc release];

	types = [NSArray arrayWithObject: NSStringPboardType];
	[pboard declareTypes: types
	               owner: nil];

	NSString *equationResult = 
		[[NSString alloc] initWithData: data
		                      encoding: NSUTF8StringEncoding];
	[pboard setString: [NSString stringWithFormat:@"%@ = %@", 
							equation, equationResult ]
			  forType: NSStringPboardType];
	[equationResult release];
}
@end

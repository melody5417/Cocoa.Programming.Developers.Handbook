#import <Cocoa/Cocoa.h>

int main(void)
{
	[NSAutoreleasePool new];
	NSData *data = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
	NSPasteboard *pboard = [NSPasteboard generalPasteboard];
	[pboard declareTypes: [NSArray arrayWithObject: NSStringPboardType]
				   owner: nil];
	[pboard setData: data forType: NSStringPboardType];
	return 0;
}

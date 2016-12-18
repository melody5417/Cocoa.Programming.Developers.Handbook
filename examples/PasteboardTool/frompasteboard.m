#import <Cocoa/Cocoa.h>

int main(void)
{
	[NSAutoreleasePool new];
	NSPasteboard *pboard = [NSPasteboard generalPasteboard];
	NSData *data = [pboard dataForType: NSStringPboardType];
	if (data == nil)
	{
		NSLog(@"Unable to get string from pasteboard.  Types are: %@",
				[pboard types]);
		return 1;
	}
	NSFileHandle *standardout = [NSFileHandle fileHandleWithStandardOutput];
	[standardout writeData: data];
	return 0;
}

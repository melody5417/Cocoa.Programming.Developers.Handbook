#import <Cocoa/Cocoa.h>

int main(void)
{
	[NSAutoreleasePool new];
	NSPasteboard *pboard = [NSPasteboard generalPasteboard];
	NSInteger version  = [pboard changeCount];
	while (1)
	{
		id pool = [NSAutoreleasePool new];
		NSInteger newversion = [pboard changeCount];
		if (newversion != version)
		{
			printf("Version %lld\n", (long long)newversion);
			version = newversion;
		}
		[pool release];
		sleep(1);
	}
}

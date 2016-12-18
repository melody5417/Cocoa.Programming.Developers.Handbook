#import <Foundation/Foundation.h>

int main(void)
{
	[NSAutoreleasePool new];
	
	NSTask *du = [[NSTask alloc] init];
	[du setLaunchPath: @"/usr/bin/du"];
	
	NSTask *sort = [[NSTask alloc] init];
	[sort setLaunchPath: @"/usr/bin/sort"];

	NSPipe *pipe = [NSPipe pipe];
	[du setStandardOutput: pipe];
	[sort setStandardInput: pipe];

	[sort launch];
	[du launch];
	[sort waitUntilExit];
	return 0;
}

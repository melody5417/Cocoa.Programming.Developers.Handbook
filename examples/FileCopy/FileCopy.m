#import <Foundation/Foundation.h>

int main(void)
{
	[NSAutoreleasePool new];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *source = [defaults stringForKey: @"in"];
	NSString *destination  = [defaults stringForKey: @"out"];
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm copyPath: source
		  toPath: destination
		 handler: nil];
	return 0;
}

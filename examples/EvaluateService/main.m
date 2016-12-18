#import <Cocoa/Cocoa.h>
#import "Evaluate.h"

int main(int argc, char *argv[])
{
	[NSAutoreleasePool new];
	NSRegisterServicesProvider([Evaluate new], @"EvaluateService");
	NSUpdateDynamicServices();
	// Required on OS X 10.4 and below.
	//[[NSRunLoop currentRunLoop] configureAsServer];
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

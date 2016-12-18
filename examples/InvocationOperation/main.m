#import "Fibonacci.h"

int main(void)
{
	[NSAutoreleasePool new];
	NSInvocationOperation* op = 
		[[NSInvocationOperation alloc] initWithTarget: [Fibonacci new]
											 selector: @selector(fibonacci:)
											   object: (id)40];
	NSOperationQueue *q = [NSOperationQueue new];
	[q addOperation: op];
	sleep(1);
	printf("op finished: %d running: %d\n", [op isFinished], [op isExecuting]);
	[q waitUntilAllOperationsAreFinished];
	printf("op result: %ld\n", (int)[op result]);
	return 0;
}

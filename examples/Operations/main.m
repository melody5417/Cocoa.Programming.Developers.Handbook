#import "Fibonacci.h"

int main(void)
{
	[NSAutoreleasePool new];
	Fibonacci* op = [[Fibonacci alloc] initWithStart: 40];
	Fibonacci* op2 = [[Fibonacci alloc] initWithStart: 40];
	NSOperationQueue *q = [NSOperationQueue new];
	[q addOperation: op];
	[q addOperation: op2];
	sleep(1);
	printf("op finished: %d running: %d\n", [op isFinished], [op isExecuting]);
	printf("op2 finished: %d running: %d\n", [op2 isFinished], [op2 isExecuting]);
	[op2 cancel];
	[q waitUntilAllOperationsAreFinished];
	printf("op result: %ld\n", (int)[op result]);
	printf("op2 result: %ld\n", (int)[op2 result]);
	return 0;
}

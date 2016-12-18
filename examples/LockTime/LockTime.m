#import <Foundation/Foundation.h>
#include <time.h>
#include <pthread.h>
#include <libkern/OSAtomic.h>

volatile int32_t a;

#define TIME_START() a=0 ; c1 = clock(); \
	for (unsigned i=0 ; i<100000000 ; i++) {
#define TIME_END(message) \
	} c2 = clock();\
	difference = ((double)c2 - (double)c1) / (double)CLOCKS_PER_SEC;\
	printf(message " took %f seconds. (%d times longer)\n", difference, \
	(int)(difference / normal));

int main(void)
{
	[NSAutoreleasePool new];
	clock_t c1,c2;
	double difference;
	double normal = 1;
	TIME_START()
		a++;
	TIME_END("Lock free version");
	normal = difference;
	NSLock *lock = [NSLock new];
	TIME_START()
		[lock lock]; a++; [lock unlock];
	TIME_END("NSLock version");
	lock = [NSRecursiveLock new];
	TIME_START()
		[lock lock]; a++; [lock unlock];
	TIME_END("NSRecursiveLock version");
	pthread_mutex_t mutex;
	pthread_mutex_init(&mutex, NULL);
	TIME_START()
		pthread_mutex_lock(&mutex); a++; pthread_mutex_unlock(&mutex);
	TIME_END("POSIX mutex version");
	TIME_START()
		OSAtomicIncrement32(&a);
	TIME_END("Atomic function version");
	TIME_START()
		__asm__ __volatile__ ("lock addl $1, %0"
				                          :"=m" (a));
	TIME_END("Atomic assembly version");
	TIME_START()
		__sync_fetch_and_add(&a, 1);
	TIME_END("Atomic GCC version");

	return 0;
}

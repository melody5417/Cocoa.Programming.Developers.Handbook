#import "SharedData.h"
#include <sys/mman.h>

@implementation SharedData
- (id) initWithSharedFile: (NSString*) aFile size: (NSUInteger) aSize
{
	if (nil == (self = [self init])) { return nil; }
	int file = open([aFile UTF8String], O_RDWR | O_CREAT, 0600);
	lseek(file, (off_t) aSize+1, SEEK_SET);
	write(file, "\0", 1);
	bytes = mmap(NULL, 
			aSize, 
			PROT_READ | PROT_WRITE, 
			MAP_FILE | MAP_SHARED,
			file,
			0);
	close(file);
	length = aSize;
	return self;
}
- (void) dealloc
{
	munmap(bytes, length);
	[super dealloc];
}
- (NSUInteger)length
{
	return length;
}
- (const void *)bytes
{
	return bytes;
}
- (void *)mutableBytes
{
	return bytes;
}
- (void)setLength:(NSUInteger)length
{
	if (length <= aSize) return;
	[NSException raise: @"SharedMemoryResizeException"
				format: @"You can not resize shared memory"];
}
@end

#include <objc/Runtime.h>
#include <stdio.h>

int main(void)
{
	// Look up the classes we need
	Class NSObject= (Class)objc_getClass("NSObject");
	Class NSAutoreleasePool = (Class)objc_getClass("NSAutoreleasePool");
	// Cache some selectors.
	SEL new = sel_getUid("new");
	SEL description = sel_getUid("description");
	SEL UTF8String = sel_getUid("UTF8String");
	// Create the autorelease pool
	objc_msgSend(NSAutoreleasePool, new);
	// Create the NSObject instance in two steps.
	id obj = (id)objc_msgSend(NSObject, new);
	// id descString = [obj description];
	IMP descMethod = class_getMethodImplementation(obj->isa, description);
	id descString = descMethod(obj, description);
	// char *desc = [descString UTF8String];
	char *desc = (char*)objc_msgSend(descString, UTF8String);
	printf("Created object: %s\n", desc);
	return 0;
}

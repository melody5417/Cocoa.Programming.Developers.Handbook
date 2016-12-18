#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

static void printPropertyIfString(NSString *key, id value, ABPropertyType type)
{
	if (type & kABStringProperty)
	{
		if ((type & kABMultiValueMask))
		{
			for (id subvalue in value)
			{
				printPropertyIfString(key, subvalue, type ^ kABMultiValueMask);
			}
		}
		else
		{
			printf("%s: %s\n", [key UTF8String], [value UTF8String]);
		}
	}
}

int main(void)
{
	[NSAutoreleasePool new];
	ABAddressBook *book = [ABAddressBook sharedAddressBook];
	for (ABPerson *person in [book people])
	{
		for (NSString *property in [ABPerson properties])
		{
			ABPropertyType type = [ABPerson typeOfProperty:property];
			id value = [person valueForProperty:property];
			if (value != nil)
			{
				printPropertyIfString(property, value, type);
			}
		}
	}
}

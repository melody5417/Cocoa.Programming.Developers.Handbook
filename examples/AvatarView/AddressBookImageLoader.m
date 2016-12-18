#import "AddressBookImageLoader.h"
#import <AddressBook/AddressBook.h>

@implementation AddressBookImageLoader
- (void) awakeFromNib
{
	[view setRowHeight:128];
	[self willChangeValueForKey:@"images"];
	images = [NSMutableArray array];
	for (ABPerson *person in [[ABAddressBook sharedAddressBook] people])
	{
		NSData *imageData = [person imageData];
		if (nil != imageData)
		{
			[images addObject:imageData];
		}
	}
	[self didChangeValueForKey:@"images"];
}
- (NSMutableArray*)images
{
	return images;
}
@end

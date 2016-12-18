#import "MeetingController.h"
#import <CalendarStore/CalendarStore.h>
#import <AddressBook/AddressBook.h>

@implementation MeetingController
- (void) awakeFromNib
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self
	           selector: @selector(selectionChanged:)
	               name: ABPeoplePickerNameSelectionDidChangeNotification
	             object: peopleView];
	[center addObserver: self
	           selector: @selector(selectionChanged:)
	               name: CalEventsChangedExternallyNotification
	             object: [CalCalendarStore defaultCalendarStore]];
}
- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}
- (void) selectionChanged:(NSNotification*)notification
{
	CalCalendarStore *store = [CalCalendarStore defaultCalendarStore];
	NSArray *people = [peopleView selectedRecords];
	NSArray *events = nil;
	if ([people count] > 0)
	{
		NSPredicate *predicate = 
			[CalCalendarStore eventPredicateWithStartDate: [NSDate date]
												  endDate: [NSDate distantFuture]
												calendars: [store calendars]];
		NSArray *events = [store eventsWithPredicate: predicate];
		names = [NSMutableArray array];
		for (ABPerson *person in people)
		{
			NSString *name = [NSString stringWithFormat:@"%@ %@",
							  [person valueForProperty:kABFirstNameProperty],
							  [person valueForProperty:kABLastNameProperty]];
			[names addObject:name];
		}
		predicate = [NSPredicate predicateWithFormat: 
			@"ANY attendees.commonName IN %@", names];
		events = [events filteredArrayUsingPredicate:predicate];
	}
	[self willChangeValueForKey:@"meetings"];
	[meetings release];
	meetings = [events retain];
	[self didChangeValueForKey:@"meetings"];
}
@end

#import <Cocoa/Cocoa.h>
#import <AddressBook/ABPeoplePickerView.h>

@interface MeetingController : NSObject {
	IBOutlet ABPeoplePickerView *peopleView;
	IBOutlet NSMutableArray *meetings;
}
@end

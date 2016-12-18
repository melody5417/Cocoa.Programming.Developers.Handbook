#import <Cocoa/Cocoa.h>

@interface OutlineItem : NSObject<NSCoding>{
	NSString *title;
	NSMutableArray *children;
}
@property (retain, nonatomic, readwrite) NSString *title;
@property (retain, nonatomic, readwrite) NSMutableArray *children;
@end

#import <Cocoa/Cocoa.h>
#import	<QTKit/QTKit.h>

@interface MoviePlayer : NSObject {
	IBOutlet NSWindow *window;
	BOOL loop;
	QTMovie *movie;
}
@property (nonatomic, retain) QTMovie *movie;
- (IBAction)open: (id)sender;
- (IBAction)setLoop: (id)sender;
@end

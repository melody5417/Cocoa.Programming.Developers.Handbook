#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface SoundPlayer : NSObject {
	QTMovie *sound;
	IBOutlet NSWindow *window;
	IBOutlet NSSlider *progress;
	BOOL loop;
}
- (IBAction)open: (id)sender;
- (IBAction)setLoop: (id)sender;
- (IBAction)play: (id)sender;
- (IBAction)stop: (id)sender;
- (IBAction)takeCurrentTimeFrom: (id)sender;
@end

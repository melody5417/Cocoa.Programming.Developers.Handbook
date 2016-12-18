#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface VideoRecorder : NSObject {
	QTCaptureSession *session;
	QTCaptureFileOutput *file;
	IBOutlet QTCaptureView *view;
}
- (IBAction)record: (id)sender;
@end

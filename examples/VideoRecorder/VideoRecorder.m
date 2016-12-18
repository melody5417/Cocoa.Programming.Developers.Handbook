#import "VideoRecorder.h"

@implementation VideoRecorder
- (void)awakeFromNib
{
	session = [QTCaptureSession new];
	QTCaptureDevice *camera = 
		[QTCaptureDevice defaultInputDeviceWithMediaType: 
			QTMediaTypeVideo];
	[camera open: NULL];
	QTCaptureInput *input = 
		[[QTCaptureDeviceInput alloc] initWithDevice: camera];
	[session addInput: input
				error: NULL];
	[input release];
	file = [QTCaptureMovieFileOutput new];
	[session addOutput: file
				 error: NULL];
	[view setCaptureSession: session];
	[session startRunning];
}
- (void)startRecording
{
	NSString *path =
		[@"~/Desktop/VideoRecorder.mov" stringByExpandingTildeInPath];
	[file recordToOutputFileURL: [NSURL fileURLWithPath: path]];
}
- (void)stopRecording
{	
	[file recordToOutputFileURL: nil];
}
- (IBAction)record: (id)sender
{
	if ([sender state] == NSOnState)
	{
		[self startRecording];
	}
	else
	{
		[self stopRecording];
	}
}
@end

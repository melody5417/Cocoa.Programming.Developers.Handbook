#import "SoundPlayer.h"

@implementation SoundPlayer
- (IBAction)open: (id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel runModalForTypes: [NSArray arrayWithObjects: @"aiff", @"mp3", @"m4a", nil]];
	[sound release];
	sound = [[QTMovie movieWithFile: [openPanel filename]
							 error: NULL] retain];
	[sound setAttribute: [NSNumber numberWithBool: loop]
				 forKey: QTMovieLoopsAttribute];
	[window setTitle: [[openPanel filename] lastPathComponent]];
}
- (IBAction)setLoop: (id)sender;
{
	loop = [sender state] == NSOnState;
	[sound setAttribute: [NSNumber numberWithBool: loop]
				 forKey: QTMovieLoopsAttribute];
}
- (IBAction)play: (id)sender
{
	NSTimeInterval duration;
	QTGetTimeInterval([sound duration], &duration);
	[progress setMaxValue: duration];
	[NSTimer scheduledTimerWithTimeInterval: 0.1
									 target: self
								   selector: @selector(updateIndicator:)
								   userInfo: sound
									repeats: YES];
	[sound play];
}
- (void)updateIndicator: (NSTimer*)aTimer
{
	NSSound *playingSound = [aTimer userInfo];
	if (!(sound == playingSound && [playingSound isPlaying]))
	{
		[aTimer release];
		return;
	}
	NSTimeInterval currentTime;
	QTGetTimeInterval([sound currentTime], &currentTime);
	[progress setDoubleValue: currentTime];
}
- (IBAction)takeCurrentTimeFrom: (id)sender
{
	[sound setCurrentTime: 
		QTMakeTimeWithTimeInterval([sender doubleValue])];
}
- (IBAction)stop: (id)sender
{
	[sound stop];
}
@end

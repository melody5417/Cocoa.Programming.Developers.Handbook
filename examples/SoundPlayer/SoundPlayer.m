#import "SoundPlayer.h"

@implementation SoundPlayer
- (IBAction)open: (id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel runModalForTypes: [NSArray arrayWithObjects: @"aiff", @"mp3", @"m4a", nil]];
	[sound release];
	sound = [[NSSound alloc] initWithContentsOfFile: [openPanel filename]
										byReference: YES];
	[sound setLoops: loop];
	[window setTitle: [[openPanel filename] lastPathComponent]];
}
- (IBAction)setLoop: (id)sender;
{
	loop = [sender state] == NSOnState;
	[sound setLoops: loop];
}
- (IBAction)play: (id)sender
{
	[progress setMaxValue: [sound duration]];
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
		[aTimer invalidate];
		return;
	}
	[progress setDoubleValue: [sound currentTime]];
}
- (IBAction)takeCurrentTimeFrom: (id)sender
{
	[sound setCurrentTime: [sender doubleValue]];
}
- (IBAction)stop: (id)sender
{
	[sound stop];
}
@end

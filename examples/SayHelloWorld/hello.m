#import <Cocoa/Cocoa.h>

int main(void)
{
	[NSAutoreleasePool new];
	NSSpeechSynthesizer *speaker = [NSSpeechSynthesizer new];
	[speaker startSpeakingString: @"Hello world"];
	while ([speaker isSpeaking])
	{
		usleep(100);
	}
	return 0;
}

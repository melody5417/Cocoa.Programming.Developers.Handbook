#import "Dialog.h"

@implementation Dialog
@synthesize delegate;
- (id)init
{
	if (nil == (self = [super init])) { return nil; }
	
	speaker = [NSSpeechSynthesizer new];
	[speaker setUsesFeedbackWindow: YES];
	listener = [NSSpeechRecognizer new];
	[listener setDelegate: self];
	
	return self;
}
- (void)sayString: (NSString*)outString
{
	while ([speaker isSpeaking]) { usleep(100); }
	[speaker startSpeakingString: outString];
}
- (void) sayString: (NSString*)outString
		 listenFor: (NSArray*)commands
		  delegate: (id)aDelegate
{
	[self sayString: outString];
	[listener setCommands: commands];
	[listener startListening];
	self.delegate = aDelegate;
}
- (void)speechRecognizer: (NSSpeechRecognizer *)sender
	 didRecognizeCommand: (id)command
{
	NSString *selString = [@"speechCommand" stringByAppendingString: command];
	selString = [selString stringByReplacingOccurrencesOfString: @" " 
													 withString: @""];
	SEL sel = NSSelectorFromString(selString);
	if ([delegate respondsToSelector: sel])
	{
		[delegate performSelector: sel];
	}
	else if ([delegate respondsToSelector: @selector(speechCommand:)])
	{
		[delegate speechCommand: command];
	}
	self.delegate = nil;
	[listener stopListening];
	[listener setCommands: nil];
}
- (void)dealloc
{
	[speaker release];
	[listener release];
	[delegate release];
	[super dealloc];
}
@end

#import <Cocoa/Cocoa.h>


@interface Dialog : NSObject {
	NSSpeechSynthesizer *speaker;
	NSSpeechRecognizer *listener;
	id delegate;
}
@property (nonatomic, retain) id delegate;
- (void)sayString: (NSString*)outString
		listenFor: (NSArray*)commands
		 delegate: (id)aDelegate;
- (void)sayString: (NSString*)outString;
@end
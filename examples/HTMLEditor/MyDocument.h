#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MyDocument : NSDocument {
	IBOutlet WebView *view;
	NSString *loadedDoc;
}
@end

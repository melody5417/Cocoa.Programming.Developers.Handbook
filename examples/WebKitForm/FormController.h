#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface FormController : NSObject {
	DOMElement *formRoot;
	IBOutlet WebView *view;
	NSMutableArray *formElements;
}
@property (nonatomic, retain) DOMElement *formRoot;
@end

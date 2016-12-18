#import "FormController.h"


@implementation FormController
@synthesize formRoot;
- (void)awakeFromNib
{
	NSString *templatePath =
		[[NSBundle mainBundle] pathForResource: @"template"
										ofType: @"html"];
	NSString *template = 
		[[NSString alloc] initWithContentsOfFile: templatePath];
	[[view mainFrame] loadHTMLString: template
				  baseURL: nil];
	[view setDrawsBackground: NO];
	[view setFrameLoadDelegate: self];
	formElements = [NSMutableArray new];
}
- (void)addTextField: (NSString*)title
{
	DOMDocument *doc = [[view mainFrame] DOMDocument];
	
	DOMHTMLInputElement *textField = (DOMHTMLInputElement*)
		[doc createElement: @"input"];
	[textField setAttribute: @"type" value: @"text"];
	[formElements addObject: textField];

	DOMElement *paragraph = [doc createElement: @"p"];
	[paragraph setTextContent: title];
	[paragraph appendChild: textField];
	
	[formRoot appendChild: paragraph];
}
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	self.formRoot = [[[view mainFrame] DOMDocument] 
		getElementById: @"WebKitFormExample"];
	[self addTextField: @"Default Button"];
	[self addTextField: @"Alternate Button"];
	[self addTextField: @"Other Button"];
}
- (NSString*)textAtIndex: (NSInteger)index
{
	DOMHTMLInputElement *textField = [formElements objectAtIndex: index];
	return textField.value;
}
- (void)formSubmitted
{
	NSAlert *alert = 
		[NSAlert alertWithMessageText: @"Form completed"
						defaultButton: [self textAtIndex: 0]
					  alternateButton: [self textAtIndex: 1]
						  otherButton: [self textAtIndex: 2]
			informativeTextWithFormat: @"Buttons created from form elements"];
	[alert runModal];
}
@end

#import "FormPolicyDelegate.h"
#import <WebKit/WebKit.h>

@implementation FormPolicyDelegate
-                 (void)webView: (WebView*)sender
decidePolicyForNavigationAction: (NSDictionary*)actionInformation
						request: (NSURLRequest*)request
						  frame: (WebFrame*)frame
			   decisionListener: (id<WebPolicyDecisionListener>)listener
{
	int action = 
		[[actionInformation objectForKey: WebActionNavigationTypeKey] intValue];
	if (action == WebNavigationTypeOther)
	{
		[listener use];
		return;
	}
	if (WebNavigationTypeFormSubmitted == action)
	{
		[delegate formSubmitted];
	}
	[listener ignore];
}
@end

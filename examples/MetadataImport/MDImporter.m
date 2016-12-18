#import "MDImporter.h"
#import "OutlineItem.h"

@implementation MDImporter
- (NSString*)collectText: (OutlineItem*)item
				inBuffer: (NSMutableString*)buffer
{
	[buffer appendString: @" "];
	[buffer appendString: item.title];
	for (OutlineItem *child in item.children)
	{
		[self collectText: child
				 inBuffer: buffer];
	}
	return buffer;
}
- (BOOL)getAttributes: (NSMutableDictionary*)attributes
	   forFileWithUTI: (NSString*)aUTI
			   atPath: (NSString*)aPath
{
	OutlineItem *root =
		[NSKeyedUnarchiver unarchiveObjectWithData: [NSData dataWithContentsOfFile: aPath]];
	if (nil == root) { return NO; }
	
	[attributes setObject: root.title
				   forKey: (id)kMDItemTitle];
	NSMutableString *text = [NSMutableString string];
	[self collectText: root inBuffer: text];
	[attributes setObject: text
				   forKey: (id)kMDItemTextContent];
	return YES;
}
@end

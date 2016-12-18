#import "PrintPanelController.h"

static NSString *kImagesPerPagePath = @"representedObject.dictionary.imagesPerPage";
static NSString *kImagesPerPage = @"imagesPerPage";
@implementation PrintPanelController
- (NSSet *)keyPathsForValuesAffectingPreview
{
	[self setPagesFromSlider:slider];
	return [NSSet setWithObject: kImagesPerPagePath];
}
- (NSArray *)localizedSummaryItems
{
	return nil;
}
- (IBAction) setPagesFromSlider:(id)sender

{
	NSMutableDictionary *dict = [[self representedObject] dictionary];
	[dict willChangeValueForKey:kImagesPerPage];
	[dict setObject:[sender objectValue]
			forKey:kImagesPerPage];
	[dict didChangeValueForKey:kImagesPerPage];
}
@end

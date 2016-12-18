#import <Cocoa/Cocoa.h>
#import "OutlineItem.h"

@interface OutlineItemDictionaryTransformer : NSObject {

}
+ (NSDictionary*) dictionaryForOutlineItem:(OutlineItem*)item;
+ (OutlineItem*) outlineItemFromDictionary:(NSDictionary*)dict;
@end

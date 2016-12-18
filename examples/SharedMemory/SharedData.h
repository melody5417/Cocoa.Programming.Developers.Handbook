#import <Foundation/Foundation.h>

@interface SharedData : NSMutableData {
	NSUInteger length;
	void * bytes;
}
- (id) initWithSharedFile: (NSString*)aFile size: (NSUInteger)aSize;
@end

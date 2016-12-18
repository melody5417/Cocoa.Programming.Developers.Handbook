#import "ContextMenuView.h"

static NSMenu *defaultMenu;

@implementation ContextMenuView
+ (NSMenu*)defaultMenu
{
	if (nil == defaultMenu)
	{
		@synchronized(self)
		{
			if (nil == defaultMenu)
			{
				defaultMenu = [NSMenu new];
				[defaultMenu addItemWithTitle: @"Copy"
									   action: @selector(copy:)
								keyEquivalent: @"c"];
				[defaultMenu addItemWithTitle: @"Paste"
									   action: @selector(paste:)
								keyEquivalent: @"v"];
			}
		}
	}
	return defaultMenu;
}
static BOOL addItemsToMenuFromMenu(NSMenu *menu, NSMenu *template)
{
	for (NSMenuItem *item in [template itemArray])
	{
		NSMenuItem *itemCopy = [item copy];
		[menu addItem: itemCopy];
		[itemCopy release];
	}
	return [menu numberOfItems] > 0;
}
- (NSMenu*)menuForEvent: (NSEvent*)theEvent
{
	NSPoint click = [self convertPoint: [theEvent locationInWindow]
							  fromView: nil];
	
	NSMenuItem *locationMenuItem =
		[[NSMenuItem alloc] initWithTitle: NSStringFromPoint(click)
								   action: NULL
							keyEquivalent: @""];
	[locationMenuItem setEnabled: NO];
	NSMenu *menu = [NSMenu new];
	[menu addItem: locationMenuItem];
	[locationMenuItem release];
	[menu addItem: [NSMenuItem separatorItem]];
	if (addItemsToMenuFromMenu(menu, [self menu]))
	{
		[menu addItem: [NSMenuItem separatorItem]];
	}
	addItemsToMenuFromMenu(menu, [[self class] defaultMenu]);
	return [menu autorelease];
}
@end

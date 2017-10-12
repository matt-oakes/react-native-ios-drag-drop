#import "MODragView.h"

@interface MODragView () <UIDragInteractionDelegate>
@end

@implementation MODragView
{
    UIDragInteraction *_dragInteraction;
    NSArray<MODragItem *> *_dragItems;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
        _dragItems = nil;
        
        [self addInteraction:_dragInteraction];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark - UIDragInteractionDelegate

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    // Shortcut if there are no drag items set
    if (!_dragItems || _dragItems.count == 0) {
        return @[];
    }
    
    // Map the MODragItems to UIDragItems
    // This allows us to store the drag items in our own format and only create the UIDragItems when needed
    NSMutableArray<UIDragItem *> *uiDragItems = [[NSMutableArray alloc] initWithCapacity:_dragItems.count];
    [_dragItems enumerateObjectsUsingBlock:^(MODragItem * _Nonnull dragItem, NSUInteger index, BOOL * _Nonnull stop) {
        [uiDragItems addObject:dragItem.uiDragItem];
    }];
    return [[NSArray alloc] initWithArray:uiDragItems];
}

@end

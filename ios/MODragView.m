#import <React/RCTComponent.h>
#import "MODragView.h"
#import "MODragPreviewView.h"

@interface MODragView () <UIDragInteractionDelegate>
@end

@implementation MODragView
{
    UIDragInteraction *_dragInteraction;
    NSArray<MODragItem *> *_dragItems;
    // We keep track of the preview view and the index it was added at if we are given one
    NSInteger _previewReactSubviewIndex;
    UIView *_previewReactSubview;
    // We keep track of the React subviews ourself so we can handle the preview view ourself
    NSMutableArray<UIView *> *_reactSubviews;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
        _dragItems = nil;
        _previewReactSubviewIndex = -1;
        _previewReactSubview = nil;
        _reactSubviews = [[NSMutableArray alloc] init];
        
        [self addInteraction:_dragInteraction];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark - React subviews

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)insertReactSubview:(id<RCTComponent>)subview atIndex:(NSInteger)atIndex {
    if ([subview isKindOfClass:[MODragPreviewView class]]) {
        // Keep track of the preview view and don't add it to the actual view subviews
        _previewReactSubviewIndex = atIndex;
        _previewReactSubview = (UIView *)subview;
    } else {
        // If it's not a preview view, just add it as normal, but take into accoun
        NSInteger index = (_previewReactSubviewIndex != -1 && atIndex > _previewReactSubviewIndex) ? atIndex - 1 : atIndex;
        [super insertSubview:(UIView *)subview atIndex:index];
    }
    
    // Keep track of the subviews so we can return them when required
    [_reactSubviews insertObject:(UIView *)subview atIndex:(NSUInteger)atIndex];
}

- (void)removeReactSubview:(id<RCTComponent>)subview {
    if ([subview isKindOfClass:[MODragPreviewView class]]) {
        // We no longer have a preview view, so remove the references to it
        _previewReactSubviewIndex = -1;
        _previewReactSubview = nil;
    } else {
        // Otherwise, just remove it as normal
        [(UIView *)subview removeFromSuperview];
    }
    
    // Keep our array up-to-date so we can respond correctly
    [_reactSubviews removeObject:(UIView *)subview];
}

- (NSArray<id<RCTComponent>> *)reactSubviews {
    return (NSArray<id<RCTComponent>> *)_reactSubviews;
}
#pragma clang diagnostic pop

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
        UIDragItem *uiDragItem = dragItem.uiDragItem;
        if (_previewReactSubview) {
            uiDragItem.previewProvider = ^UIDragPreview * _Nullable{
                return [[UIDragPreview alloc] initWithView:_previewReactSubview];
            };
        }
        [uiDragItems addObject:uiDragItem];
    }];
    return [[NSArray alloc] initWithArray:uiDragItems];
}

@end

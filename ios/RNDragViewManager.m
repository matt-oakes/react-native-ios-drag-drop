#import <UIKit/UIKit.h>
#import "RNDragViewManager.h"
#import "MODragView.h"

@interface RNDragViewManager() <UIDragInteractionDelegate>
@end

@implementation RNDragViewManager
{
    UIDragInteraction *_dragInteraction;
    NSArray<MODragItem *> *_dragItems;
}

#pragma mark - Props

RCT_CUSTOM_VIEW_PROPERTY(dragItems, NSArray<MODragItem *>, MODragView)
{
    if ([json isKindOfClass:[NSString class]] && ![json isEqualToString:@""]) {
        _dragItems = @[ [[MODragItem alloc] initWithTitle:json] ];
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSMutableArray<MODragItem *> *dragItems = [[NSMutableArray alloc] init];
        [json enumerateObjectsUsingBlock:^(id _Nonnull possibleDragItem, NSUInteger index, BOOL * _Nonnull stop) {
            // TODO: This should be able to handle more complex cases with callbacks
            if ([possibleDragItem isKindOfClass:[NSString class]] && ![possibleDragItem isEqualToString:@""]) {
                [dragItems addObject:[[MODragItem alloc] initWithTitle:possibleDragItem]];
            }
        }];
        
        _dragItems = [[NSArray alloc] initWithArray:dragItems];
    } else {
        _dragItems = nil;
    }
    [view setDragItems:_dragItems];
}

#pragma mark - Setup and view handling

RCT_EXPORT_MODULE()

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    }
    return self;
}

- (MODragView *)view {
    MODragView *view = [[MODragView alloc] init];
    [view addInteraction:_dragInteraction];
    [view setUserInteractionEnabled:YES];
    [view setDragItems:@[]];
    return view;
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
  

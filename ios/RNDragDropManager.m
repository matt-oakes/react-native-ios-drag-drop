@import UIKit;
#import "RNDragDropManager.h"

@interface RNDragDropManager() <UIDragInteractionDelegate>
@end

@implementation RNDragDropManager
{
    UIDragInteraction *_dragInteraction;
}

RCT_EXPORT_MODULE()

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    }
    return self;
}

- (UIView *)view {
    UIView *view = [[UIView alloc] init];
    [view addInteraction:_dragInteraction];
    [view setUserInteractionEnabled:YES];
    return view;
}

#pragma mark - UIDragInteractionDelegate

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    // TODO: Allow the user to set this themselves from the React component
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:@"Some text"];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[ dragItem ];
}

@end
  

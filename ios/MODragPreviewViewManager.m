#import "MODragPreviewViewManager.h"
#import "MODragPreviewView.h"

@implementation MODragPreviewViewManager

RCT_EXPORT_MODULE()

- (MODragPreviewView *)view {
    return [[MODragPreviewView alloc] init];
}

@end

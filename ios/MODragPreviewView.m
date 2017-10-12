#import "MODragPreviewView.h"
#import "MODragView.h"

@implementation MODragPreviewView

- (void)didMoveToSuperview {
    if ([self.superview isKindOfClass:[MODragView class]]) {
        [self removeFromSuperview];
    }
}

@end

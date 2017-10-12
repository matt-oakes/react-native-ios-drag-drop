#import <UIKit/UIKit.h>
#import <React/RCTLog.h>

#import "MODragViewManager.h"
#import "MODragView.h"

@implementation MODragViewManager

#pragma mark - Props

RCT_CUSTOM_VIEW_PROPERTY(dragItems, NSArray<MODragItem *>, MODragView)
{
    if ([json isKindOfClass:[NSArray class]]) {
        NSMutableArray<MODragItem *> *dragItems = [[NSMutableArray alloc] init];
        [json enumerateObjectsUsingBlock:^(id _Nonnull possibleDragItem, NSUInteger index, BOOL * _Nonnull stop) {
            // TODO: This should be able to handle more complex drag items too
            if ([possibleDragItem isKindOfClass:[NSString class]] && ![possibleDragItem isEqualToString:@""]) {
                [dragItems addObject:[[MODragItem alloc] initWithTitle:possibleDragItem]];
            } else {
                RCTLogWarn(@"RNDragViewManager was passed a dragItem that was not a string\n\n%@", possibleDragItem);
            }
        }];
        
        [view setDragItems:[[NSArray alloc] initWithArray:dragItems]];
    } else {
        RCTLogWarn(@"RNDragViewManager was passed a dragItems prop with the wrong format\n\n%@", json);
        [view setDragItems:nil];
    }
}

RCT_CUSTOM_VIEW_PROPERTY(preview, RCTResponseSenderBlock, MODragView)
{
    NSLog(@"Incoming preview: %@", json);
}

#pragma mark - Setup and view handling

RCT_EXPORT_MODULE()

- (MODragView *)view {
    return [[MODragView alloc] init];
}

@end
  

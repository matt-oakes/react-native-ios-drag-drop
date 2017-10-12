#import <Foundation/Foundation.h>

@interface MODragItem : NSObject

@property (nonatomic, strong, nonnull) NSString *title;

- (instancetype _Nonnull)initWithTitle:(NSString * _Nonnull)title;

- (UIDragItem * _Nonnull)uiDragItem;

@end

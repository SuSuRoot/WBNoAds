#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface SBIconView : UIView
- (id)icon;
- (void)_openQuickActions;
@end

%hook SBIconView

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];

    if (currentLocation.y < previousLocation.y) {
        // 检测到上划手势
        [self _openQuickActions];
    } else {
        %orig;
    }
}

%end

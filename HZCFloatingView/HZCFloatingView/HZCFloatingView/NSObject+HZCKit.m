//
//  NSObject+HZCKit.m
//  HZCKit
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import "NSObject+HZCKit.h"

@implementation NSObject (HZCKit)

- (UIViewController *)hzc_currentViewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *) vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *) vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    return vc;
}

- (UINavigationController *)hzc_currentNavigationController {
    return [self hzc_currentViewController].navigationController;
}

- (UITabBarController *)hzc_currentTabBarController {
    return [self hzc_currentViewController].tabBarController;
}
@end

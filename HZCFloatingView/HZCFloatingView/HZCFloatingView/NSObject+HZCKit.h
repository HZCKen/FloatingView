//
//  NSObject+HZCKit.h
//  HZCKit
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (HZCKit)

- (UIViewController *)hzc_currentViewController;

- (UINavigationController *)hzc_currentNavigationController;

- (UITabBarController *)hzc_currentTabBarController;

@end

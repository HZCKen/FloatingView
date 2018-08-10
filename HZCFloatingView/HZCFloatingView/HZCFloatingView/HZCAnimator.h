//
//  HZCAnimated.h
//  HZCFloatingView
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HZCAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/** <#Description#> */
@property (nonatomic, assign) CGRect currentFrame;

/** <#Description#> */
@property (nonatomic, assign) UINavigationControllerOperation operation;

/** <#Description#> */
@property (nonatomic, copy) void (^animDidStop)(UINavigationControllerOperation operation);

@end

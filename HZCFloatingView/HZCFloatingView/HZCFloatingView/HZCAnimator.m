//
//  HZCAnimated.m
//  HZCFloatingView
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import "HZCAnimator.h"
#import "HZCAnimatorView.h"
@implementation HZCAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    
    if (self.operation == UINavigationControllerOperationPush) {
        UIView *containerView = transitionContext.containerView;
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        [containerView addSubview:toView];
        
        //隐藏toView 用animatorView做动画
        HZCAnimatorView *animatorView = [[HZCAnimatorView alloc]initWithFrame:toView.bounds];
        [containerView addSubview:animatorView];
        
        //截屏，赋值给animatorView
        UIGraphicsBeginImageContext(toView.frame.size);
        [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
        animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        toView.hidden = YES;
        
        [animatorView startAnimatingWithView:toView fromRect:self.currentFrame toRect:toView.frame];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //动画结束后才移除
            [transitionContext completeTransition:YES];//移除fromView,fromViewController
            if (self.animDidStop) {
                self.animDidStop(self.operation);
            }
        });
    } else {
        
        UIView *containerView = transitionContext.containerView;
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        //隐藏toView 用animatorView做动画
        HZCAnimatorView *animatorView = [[HZCAnimatorView alloc]initWithFrame:fromView.bounds];
        [containerView addSubview:animatorView];
        
        //截屏，赋值给animatorView
        UIGraphicsBeginImageContext(fromView.frame.size);
        [fromView.layer renderInContext:UIGraphicsGetCurrentContext()];
        animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        fromView.hidden = YES;
        
        [animatorView startAnimatingWithView:fromView fromRect:fromView.frame toRect:self.currentFrame];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //动画结束后才移除
            [transitionContext completeTransition:YES];//移除fromView,fromViewController
            if (self.animDidStop) {
                self.animDidStop(self.operation);
            }
        });
   
    }
    

    
    
    
}

@end

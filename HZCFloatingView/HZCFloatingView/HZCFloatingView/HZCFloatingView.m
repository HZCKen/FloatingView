//
//  HZCFloatingView.m
//  HZCFloatingView
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import "HZCFloatingView.h"
#import "HZCSemiCircleView.h"
#import "HZCAnimator.h"
#import "NSObject+HZCKit.h"

#define fixedSpace 160.f

@interface HZCFloatingView ()<UINavigationControllerDelegate>


/** <#Description#> */
@property (nonatomic, assign) CGPoint lastPoint;
/** <#Description#> */
@property (nonatomic, assign) CGPoint pointInSelf;

/** <#Description#> */
@property (nonatomic, strong) UIViewController *floatVC;

@end

@implementation HZCFloatingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.contents = (__bridge id)[UIImage imageNamed:@"FloatingView@2x.png"].CGImage;
    }
    return self;
}



static HZCFloatingView *floatingView;
static HZCSemiCircleView *semiCircleView;
+ (void)showWithFloatVC:(UIViewController *)floatVC {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatingView = [[HZCFloatingView alloc]initWithFrame:CGRectMake(10, 100, 60, 60)];
        semiCircleView = [[HZCSemiCircleView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace)];
    });
    
    if (!semiCircleView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:semiCircleView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:semiCircleView];
    }
    
    if (!floatingView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:floatingView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatingView];
    }
    floatingView.floatVC = floatVC;
    floatingView.frame = CGRectMake(10, 100, 60, 60);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.superview];
    self.pointInSelf = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    //展开 四分一圆
    if (CGRectEqualToRect(semiCircleView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace))) {
        
        [UIView animateWithDuration:0.25 animations:^{
            semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - fixedSpace, [UIScreen mainScreen].bounds.size.height - fixedSpace, fixedSpace, fixedSpace);
        }];
    }
    
    //计算中心点
    CGFloat centerX = currentPoint.x - (self.frame.size.width / 2 - self.pointInSelf.x);
    CGFloat centerY = currentPoint.y - (self.frame.size.height / 2 - self.pointInSelf.y);
    //修改中心点位置，并限制范围
    CGFloat x = MAX(30.0f, MIN([UIScreen mainScreen].bounds.size.width - 30.0f,  centerX));
    CGFloat y = MAX(30.0f, MIN([UIScreen mainScreen].bounds.size.height - 30.0f,  centerY));
    
    self.center = CGPointMake(x, y);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    if (CGPointEqualToPoint(self.lastPoint, currentPoint)) {
        //点击效果
        
        UINavigationController *nav = [self hzc_currentNavigationController];
        nav.delegate = self;
        [nav pushViewController:self.floatVC animated:YES];
        
        [self distanceLeftOrRightMarginWithDuartion:0.0];
        semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace);
        return;
    }
    
    //动画收缩
    [UIView animateWithDuration:0.25 animations:^{
        // 如果floatingView在semiCircleView内部，就移除
        CGFloat distance = sqrt(pow([UIScreen mainScreen].bounds.size.width - self.center.x, 2) + pow([UIScreen mainScreen].bounds.size.height - self.center.y, 2) );
        if (distance <= fixedSpace - 30) {
            [self removeFromSuperview];
        }
        semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace);
    }];
    
    [self distanceLeftOrRightMarginWithDuartion:0.25];
}

/** 计算左右2侧的距离并以多长时间动画移动 */
- (void)distanceLeftOrRightMarginWithDuartion:(NSTimeInterval)duartion {
    //计算左右2侧的距离
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = [UIScreen mainScreen].bounds.size.width - leftMargin;
    
    if (leftMargin < rightMargin) {
        [UIView animateWithDuration:duartion animations:^{
            self.center = CGPointMake(40.f, self.center.y);
        }];
    } else {
        [UIView animateWithDuration:duartion animations:^{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40.f, self.center.y);
        }];
    }
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if (self.floatVC) {
        HZCAnimator *animator = [[HZCAnimator alloc]init];
        animator.currentFrame = self.frame;
        animator.operation = operation;
        if (operation == UINavigationControllerOperationPush) {
            if (toVC != self.floatVC) {
                return nil;
            }
            self.hidden = YES;
            return animator;
        } else if (operation == UINavigationControllerOperationPop) {
            if (fromVC != self.floatVC) {
                return nil;
            }
            self.hidden = NO;
            return animator;
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
    
    
}


@end

//
//  HZCAnimatorView.m
//  HZCFloatingView
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import "HZCAnimatorView.h"

@interface HZCAnimatorView ()<CAAnimationDelegate>
/** <#Description#> */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/** <#Description#> */
@property (nonatomic, strong) UIView *toView;
@end

@implementation HZCAnimatorView

- (void)startAnimatingWithView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    self.toView = theView;
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30].CGPath;
    self.layer.mask = self.shapeLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30].CGPath;
    anim.duration = 0.5f;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [self.shapeLayer addAnimation:anim forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.toView.hidden = NO;
    [self.shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}

@end

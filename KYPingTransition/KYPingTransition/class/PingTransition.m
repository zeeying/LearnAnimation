//
//  PingTransition.m
//  KYPingTransition
//
//  Created by zengzheying on 15/12/17.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "PingTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface PingTransition ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PingTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contView = [transitionContext containerView];
    UIButton *button = fromVC.button;
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    
    CGPoint finalPoint;
    if (button.frame.origin.x > (toVC.view.bounds.size.width / 2)) {
        if (button.frame.origin.y < toVC.view.bounds.size.height / 2) {
            finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds) + 30);
        } else {
            finalPoint = CGPointMake(button.center.x - 0, button.center.y - 0);
        }
    } else {
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds) + 30);
        } else {
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);
        }
    }
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

- (void)finishInteractiveTransition
{
    [self.transitionContext finishInteractiveTransition];
}

- (void)cancelInteractiveTransition
{
    [self.transitionContext cancelInteractiveTransition];
}
@end

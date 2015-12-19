//
//  PingInvertTransition.m
//  KYPingTransition
//
//  Created by zengzheying on 15/12/17.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "PingInvertTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface PingInvertTransition ()

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PingInvertTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
//    NSLog(@"star time: %f", [transitionContext.containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil]);
    
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor yellowColor];
    UIButton *button = toVC.button;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
//    NSLog(@"add time: %f", [containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil]);
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    CGPoint finalPoint;
    
    if (button.frame.origin.x > (toVC.view.bounds.size.width) / 2) {
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
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
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    NSLog(@"mod tim1: %f", [containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil]);
    //maskLayer.path = finalPath.CGPath 当需要实现手势控制动画进度时，不要把path设成最后的状态，因为如果用户取消手势返回，动画回滚，会出现闪屏的现象，选择设置removedOnCompletion和fillMode来实现动画结果的效果吧
    maskLayer.path = startPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
//    NSLog(@"mod tim2: %f", [containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil]);
    
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id)(startPath.CGPath);
    pingAnimation.toValue = (__bridge id)(finalPath.CGPath);
    pingAnimation.duration = [self transitionDuration:transitionContext];
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pingAnimation.delegate = self;
    pingAnimation.removedOnCompletion = NO;  //看上面
    pingAnimation.fillMode = kCAFillModeForwards; //看上面
    
    [maskLayer addAnimation:pingAnimation forKey:@"pathInvert"];
    
    
    //检验通过UIView的动画接口左拉返回松开手势时会不会继续动画---调用UIPercentDrivenTransition finishInteractiveTransition会继续执行
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        fromVC.view.center = CGPointMake(fromVC.view.bounds.size.width * 3 / 2, fromVC.view.bounds.size.height / 2);
//    } completion: ^(BOOL finished) {
//        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
//    }];
    
    //检验通过CABasicAnimation -- 不会继续执行，@See also http://stackoverflow.com/questions/22868376/uipercentdriveninteractivetransition-with-cabasicanimation
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    animation.fromValue = @(fromVC.view.center.x);
//    animation.toValue = @(fromVC.view.bounds.size.width * 3 / 2);
//    animation.duration = [self transitionDuration:transitionContext];
//    animation.delegate = self;
//    
//    [fromVC.view.layer addAnimation:animation forKey:@"position"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    UIView *containView = [self.transitionContext containerView];
//    NSLog(@"end time: %f speed: %f", [containView.layer convertTime:CACurrentMediaTime() fromLayer:nil], containView.layer.speed);
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end

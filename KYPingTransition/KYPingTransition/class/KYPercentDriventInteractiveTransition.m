//
//  KYPercentDriventInteractiveTransition.m
//  KYPingTransition
//
//  Created by zengzheying on 15/12/18.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

/**
 * 通过自定义UIPercentDriventInteractiveTransition来控制Transition中的CABasicAnimation的进度
 * 在示例中，当用户取消返回手势的时候，会出现UIViewControllerContextTransitioning的containerView
 * 不可见的问题，无法找到原因，只能看到layer的converttime为负数，T T，所以还是通过继承ZYPercentDrivenInteractiveTransition
 * 来实现吧
 */

#import "KYPercentDriventInteractiveTransition.h"

@implementation KYPercentDriventInteractiveTransition {
    __weak id <UIViewControllerContextTransitioning> _transitionContext;
}


- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [super startInteractiveTransition:transitionContext];
    _transitionContext = transitionContext;
}

- (void)finishInteractiveTransition {
    [super finishInteractiveTransition];
    CALayer *layer = [_transitionContext containerView].layer;
    layer.speed = 1.0;
    layer.beginTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - layer.timeOffset;
}

- (void)cancelInteractiveTransition {
    [super cancelInteractiveTransition];
    CALayer *layer = [_transitionContext containerView].layer;
    layer.speed = -1.0;
    layer.beginTime = CACurrentMediaTime();
}

@end

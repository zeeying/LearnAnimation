//
//  KYPercentDriventInteractiveTransition.m
//  KYPingTransition
//
//  Created by zengzheying on 15/12/18.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

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

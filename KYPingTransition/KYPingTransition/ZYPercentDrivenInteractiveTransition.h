//
//  ZYPercentDrivenInteractiveTransition.h
//  KYPingTransition
//
//  Created by zengzheying on 15/12/18.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYPercentDrivenInteractiveTransition : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)recognizer;

@property (nonatomic) BOOL shouldBeginInteractiveTransition;

@end

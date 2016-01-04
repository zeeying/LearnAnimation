//
//  KYPullToCurveView.m
//  AnimatedCurveDemo
//
//  Created by 曾哲影 on 15/12/27.
//  Copyright © 2015年 zengzheying. All rights reserved.
//

#import "KYPullToCurveView.h"
#import "LabelView.h"
#import "CurveView.h"
#import "UIView+Convenient.h"

@interface KYPullToCurveView ()

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, weak) UIScrollView *associatedScrollView;
@property (nonatomic, copy) void(^refreshingBlock)(void);

@end

@implementation KYPullToCurveView {
    LabelView *labelView;
    CurveView *curveView;
    
    CGFloat originOffset;
    BOOL willEnd;
    BOOL notTracking;
    BOOL loading;
}

#pragma mark - Public Method

- (instancetype)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar {
    self = [super initWithFrame:CGRectMake(scrollView.width / 2 - 200/2, -100, 200, 100)];
    
    if (self) {
        if (navBar) {
            originOffset = 64.0f;
        } else {
            originOffset = 0.0f;
        }
        
        self.associatedScrollView = scrollView;
        [self setUp];
        
        [self.associatedScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self.associatedScrollView insertSubview:self atIndex:0];
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    if (!self.associatedScrollView.tracking) {
        labelView.loading = YES;
    }
    
    if (!willEnd && !loading) {
        curveView.progress = labelView.progress = progress;
    }
    
    self.center = CGPointMake(self.center.x, -fabs(self.associatedScrollView.contentOffset.y + originOffset) / 2);
    
    CGFloat diff = fabs(self.associatedScrollView.contentOffset.y + originOffset) - self.pullDistance + 10;
    
//    NSLog(@"diff: %f = %f - %f + %f", diff, fabs(self.associatedScrollView.contentOffset.y + originOffset),
//          self.pullDistance, 10.0f);
    
    if (diff > 0) {
        if (!self.associatedScrollView.tracking) {
            if (!notTracking) {
                notTracking = YES;
                loading = YES;
                //旋转
                [self startLoading:curveView];
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.associatedScrollView.contentInset = UIEdgeInsetsMake(self.pullDistance + originOffset, 0, 0, 0);
                } completion:^(BOOL finished){
                    self.refreshingBlock();
                }];
            }
        }
        
        if (!loading) {
            curveView.transform = CGAffineTransformMakeRotation(M_PI * (diff * 2 / 180));
        }
    } else {
        labelView.loading = NO;
        curveView.transform = CGAffineTransformIdentity;
    }
}

- (void)addRefreshingBlock:(void (^)(void))block {
    self.refreshingBlock = block;
}

- (void)triggerPulling {
    [self.associatedScrollView setContentOffset:CGPointMake(0, -self.pullDistance - originOffset) animated:YES];
}

- (void)stopRefreshing {
    willEnd = YES;
    
    self.progress = 1.0;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
        self.associatedScrollView.contentInset = UIEdgeInsetsMake(originOffset + 0.1, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
        willEnd = NO;
        notTracking = NO;
        loading = NO;
        labelView.loading = NO;
        [self stopLoading:curveView];
    }];
}

#pragma mark - Helper Method

- (void)setUp {
    //一些默认参数
    self.pullDistance = 99;
    
    curveView = [[CurveView alloc] initWithFrame:CGRectMake(20, 0, 30, self.height)];
    [self insertSubview:curveView atIndex:0];

    
    labelView = [[LabelView alloc] initWithFrame:CGRectMake(curveView.right + 10, curveView.y, 150, curveView.height)];
    [self insertSubview:labelView aboveSubview:curveView];
}

- (void)startLoading:(UIView *)rotateView {
    rotateView.transform = CGAffineTransformIdentity;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 0.5f;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rotateView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading:(UIView *)rotateView {
    [rotateView.layer removeAllAnimations];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        if (contentOffset.y + originOffset <= 0) {
            self.progress = MAX(0.0, MIN(fabs(contentOffset.y + originOffset) / self.pullDistance, 1.0));
        }
    }
}

@end

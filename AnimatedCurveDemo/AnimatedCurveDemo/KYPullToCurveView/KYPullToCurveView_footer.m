//
//  KYPullToCurveView_footer.m
//  AnimatedCurveDemo
//
//  Created by 曾哲影 on 16/1/3.
//  Copyright © 2016年 zengzheying. All rights reserved.
//

#import "KYPullToCurveView_footer.h"
#import "LabelView.h"
#import "CurveView.h"
#import "UIView+Convenient.h"

@interface KYPullToCurveView_footer ()

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, weak) UIScrollView *associatedScrollView;
@property (nonatomic, copy) void(^refreshingBlock)(void);

@end

@implementation KYPullToCurveView_footer {
    LabelView *labelView;
    CurveView *curveView;
    
    CGSize contentSize;
    CGFloat originOffset;
    BOOL willEnd;
    BOOL notTracking;
    BOOL loading;
}

#pragma mark - Public Method

-(instancetype)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar {
    self = [super initWithFrame:CGRectMake(scrollView.width / 2 - 200 / 2, scrollView.height, 200, 100)];
    
    if (self) {
        if (navBar) {
            originOffset = 64.0f;
        } else {
            originOffset = 0.0f;
        }
        self.associatedScrollView = scrollView;
        [self setUp];
        [self.associatedScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.associatedScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        self.hidden = YES;
        [self.associatedScrollView insertSubview:self atIndex:0];
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress {
    if (!self.associatedScrollView.tracking) {
        labelView.loading = YES;
    }
    
    if (!willEnd && !loading) {
        curveView.progress = labelView.progress = progress;
    }
    
    CGFloat diff = self.associatedScrollView.height - (self.associatedScrollView.contentSize.height - self.associatedScrollView.contentOffset.y) - self.pullDistance + 10;
    
    if (diff > 0) {
        if (!self.associatedScrollView.tracking && !self.hidden) {
            if (!notTracking) {
                notTracking = YES;
                loading = YES;
                
                [self startLoading:curveView];
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.associatedScrollView.contentInset = UIEdgeInsetsMake(originOffset, 0, self.pullDistance, 0);
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

- (void)stopRefreshing {
    willEnd = YES;
    self.progress = 1.0;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
        self.associatedScrollView.contentInset = UIEdgeInsetsMake(originOffset, 0, 0, 0);
    } completion:^(BOOL finished){
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
    rotationAnimation.autoreverses = false;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rotateView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading:(UIView *)rotateView {
    [rotateView.layer removeAllAnimations];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        contentSize = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
        if (contentSize.height > 0.0) {
            self.hidden = NO;
        }
        self.frame = CGRectMake(self.associatedScrollView.width / 2 - 200 / 2, contentSize.height, 200, 100);
    }
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (contentOffset.y >= (contentSize.height - self.associatedScrollView.height)) {
            self.center = CGPointMake(self.center.x, contentSize.height + (self.associatedScrollView.height - (contentSize.height - contentOffset.y)) / 2);
            
            self.progress = MAX(0.0, MIN((self.associatedScrollView.height - (contentSize.height - contentOffset.y)) / self.pullDistance, 1.0));
            
        }
    }
}

@end

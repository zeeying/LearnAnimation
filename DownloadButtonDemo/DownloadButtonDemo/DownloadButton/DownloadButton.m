//
//  DownloadButton.m
//  DownloadButtonDemo
//
//  Created by 曾哲影 on 15/12/19.
//  Copyright © 2015年 zengzheying. All rights reserved.
//

#import "DownloadButton.h"

@implementation DownloadButton
{
    BOOL animating;
    CGRect originframe;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSometings];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setUpSometings];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setUpSometings];
    }
    
    return self;
}

- (void)setUpSometings
{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGes];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
}


#pragma mark - UITapGestureRecognizer
- (void)tapped:(UITapGestureRecognizer *)recognizer
{
    if (animating == YES) {
        return;
    }
    originframe = self.frame;
    for (CALayer *subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    
    self.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    
    animating = YES;
    
    self.layer.cornerRadius = self.progressBarHeight / 2;
    
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnimation.duration = 0.2f;
    radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    radiusAnimation.fromValue = @(originframe.size.height / 2);
    
    radiusAnimation.delegate = self;
    [self.layer addAnimation:radiusAnimation forKey:@"cornerRadiusShrinkAnim"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    if ([anim isEqual:[self.layer animationForKey:@"cornerRadiusShrinkAnim"]]) {
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, _progressBarWidth, _progressBarHeight);
        } completion:^(BOOL finished){
            [self.layer removeAllAnimations];
            [self progressBarAnimation];
        }];
    } else if([anim isEqual:[self.layer animationForKey:@"cornerRadiusExpandAnim"]]) {
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, originframe.size.width, originframe.size.height);
            self.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.44 alpha:1.0];
        } completion:^(BOOL finished){
            [self.layer removeAllAnimations];
            [self checkAnimation];
            animating = NO;
        }];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"progressBarAnimation"]) {
        [UIView animateWithDuration:0.3 animations:^{
            for (CALayer *subLayer in self.layer.sublayers) {
                subLayer.opacity = 0.0f;
            }
        } completion:^(BOOL finished){
            if (finished) {
                for (CALayer *subLayer in self.layer.sublayers) {
                    [subLayer removeFromSuperlayer];
                }
                NSLog(@"before cornerRadius %f", self.layer.cornerRadius);
                self.layer.cornerRadius = originframe.size.height / 2;
                NSLog(@"after  cornerRaidus %f", self.layer.cornerRadius);
                CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                radiusAnimation.duration = 0.2f;
                radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                radiusAnimation.fromValue = @(_progressBarHeight / 2);
                
                radiusAnimation.delegate = self;
                [self.layer addAnimation:radiusAnimation forKey:@"cornerRadiusExpandAnim"];
            }
        }];
    }
}


#pragma mark - Helper

- (void)progressBarAnimation {
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_progressBarHeight / 2, self.bounds.size.height / 2)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - _progressBarHeight / 2, self.bounds.size.height / 2)];
    
    progressLayer.path = path.CGPath;
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressLayer.lineWidth = _progressBarHeight - 6;
    progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:progressLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0f;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    pathAnimation.delegate = self;
    [pathAnimation setValue:@"progressBarAnimation" forKey:@"animationName"];
    [progressLayer addAnimation:pathAnimation forKey:nil];
}

- (void)checkAnimation {
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rectInCircle = CGRectInset(self.bounds, self.bounds.size.width * (1 - 1 / sqrt(2.0)) / 2, self.bounds.size.width * (1 - 1 / sqrt(2.0)) / 2);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width / 9, rectInCircle.origin.y + rectInCircle.size.height * 2 / 3)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width / 3, rectInCircle.origin.y + rectInCircle.size.height * 9 / 10)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width * 8 / 10, rectInCircle.origin.y + rectInCircle.size.height * 2 / 10)];
    
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.lineWidth = 10.0;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.3f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}

@end

//
//  SANavigationViewController.m
//  SplashAnimationDemo
//
//  Created by zengzheying on 15/12/16.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "SANavigationViewController.h"

@interface SANavigationViewController ()

@end

@implementation SANavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.position = self.view.center;
    maskLayer.bounds = CGRectMake(0, 0, 60, 60);
    self.view.layer.mask = maskLayer;
    
    UIView *maskBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maskBackgroundView];
    [self.view bringSubviewToFront:maskBackgroundView];
    
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    transformAnimation.duration = 1.0f;
    transformAnimation.beginTime = CACurrentMediaTime() + 1;
    NSValue *initalBounds = [NSValue valueWithCGRect:self.view.layer.mask.bounds];
    NSValue *secondBound = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
    NSValue *finalBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 2000, 2000)];
    
    transformAnimation.values = @[initalBounds, secondBound, finalBounds];
    transformAnimation.keyTimes = @[@(0), @(0.5), @(1)];
    transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    transformAnimation.removedOnCompletion = false;
    transformAnimation.fillMode = kCAFillModeForwards;
    [self.view.layer.mask addAnimation:transformAnimation forKey:@"maskAnimation"];
    
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
        maskBackgroundView.alpha = 0.0;
    } completion:^(BOOL finished){
        [maskBackgroundView removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
    
        self.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:1.55 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        self.view.layer.mask = nil;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

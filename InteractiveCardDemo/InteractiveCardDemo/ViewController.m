//
//  ViewController.m
//  InteractiveCardDemo
//
//  Created by zengzheying on 15/12/21.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "ViewController.h"
#import "InteractiveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    InteractiveView *interactiveView = [[InteractiveView alloc] initWithImage:[UIImage imageNamed:@"pic01"]];
    interactiveView.center = self.view.center;
    interactiveView.bounds = CGRectMake(0, 0, 200, 150);
    interactiveView.gestureView = self.view;
    
    //模糊图层
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    blurView.frame = self.view.bounds;
    [self.view addSubview:blurView];
    interactiveView.dimmingView = blurView;
    
    //interactiveView 的父视图。注意：interactiveView 和 blurView 不能添加到同一个父视图。否则透视效果会使interactiveView 穿过 blurView;
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    
    [backView addSubview:interactiveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

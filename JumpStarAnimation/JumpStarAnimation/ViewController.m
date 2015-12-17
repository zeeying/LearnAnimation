//
//  ViewController.m
//  JumpStarAnimation
//
//  Created by zengzheying on 15/12/17.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "ViewController.h"
#import "JumpStarView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet JumpStarView *jumpStarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_jumpStarView layoutIfNeeded];
    _jumpStarView.markedImage = [UIImage imageNamed:@"icon_star_incell"];
    _jumpStarView.non_markedImage = [UIImage imageNamed:@"blue_dot"];
    _jumpStarView.state = non_Mark;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapped:(id)sender {
    [_jumpStarView animate];
}

@end

//
//  ViewController.m
//  DownloadButtonDemo
//
//  Created by 曾哲影 on 15/12/19.
//  Copyright © 2015年 zengzheying. All rights reserved.
//

#import "ViewController.h"
#import "DownloadButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DownloadButton *button = [[DownloadButton alloc] initWithFrame:CGRectMake(self.view.center.x - 50, self.view.center.y - 50, 100, 100)];
    button.progressBarWidth = 200;
    button.progressBarHeight = 30;
    button.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];

    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

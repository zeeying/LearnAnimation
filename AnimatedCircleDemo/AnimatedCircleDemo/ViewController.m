//
//  ViewController.m
//  AnimatedCircleDemo
//
//  Created by zengzheying on 15/12/15.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (strong, nonatomic) CircleView *cv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.mySlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.cv = [[CircleView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 320 / 2, self.view.frame.size.height / 2 - 320 / 2, 320, 320)];
    [self.view addSubview:self.cv];
    
    self.cv.circleLayer.progress = _mySlider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged:(UISlider *)sender
{
    self.currentValueLabel.text = [NSString stringWithFormat:@"Current: %f", sender.value];
    self.cv.circleLayer.progress = sender.value;
}

@end

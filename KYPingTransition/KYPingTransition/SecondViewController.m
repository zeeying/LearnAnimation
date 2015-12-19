//
//  SecondViewController.m
//  KYPingTransition
//
//  Created by zengzheying on 15/12/17.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "SecondViewController.h"
#import "PingInvertTransition.h"
#import "KYPercentDriventInteractiveTransition.h"

@interface SecondViewController ()

@property (strong, nonatomic) PingInvertTransition *pingInvertTransition;

@end

@implementation SecondViewController
{
//    KYPercentDriventInteractiveTransition *percentInteractiveTransition;
    UIPercentDrivenInteractiveTransition *percentTransition;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgeGes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    self.pingInvertTransition.shouldBeginInteractiveTransition = YES;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self.pingInvertTransition handleGesture:recognizer];

//    float progress = [recognizer translationInView:recognizer.view].x / (recognizer.view.bounds.size.width * 1.0);
//    progress = fabsf(progress);
//    progress = MIN(1.0, MAX(0.0, progress));
//    
//    switch (recognizer.state) {
//        case UIGestureRecognizerStateBegan:
//            percentInteractiveTransition = [KYPercentDriventInteractiveTransition new];
//            [self.navigationController popViewControllerAnimated:YES];
//            break;
//        case UIGestureRecognizerStateChanged:
//            [percentInteractiveTransition updateInteractiveTransition:progress];
//            break;
//        case UIGestureRecognizerStateCancelled:
//        case UIGestureRecognizerStateEnded:
//            if (progress > 0.5) {
//                percentInteractiveTransition.completionSpeed = progress;
//                [percentInteractiveTransition finishInteractiveTransition];
//            } else {
//                percentInteractiveTransition.completionSpeed = 1.0 - progress;
//                [percentInteractiveTransition cancelInteractiveTransition];
//            }
//            percentInteractiveTransition = nil;
//            break;
//            
//        default:
//            break;
//    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.pingInvertTransition.shouldBeginInteractiveTransition ? self.pingInvertTransition : nil;
//    return percentInteractiveTransition;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return (operation == UINavigationControllerOperationPop) ? self.pingInvertTransition : nil;
}

- (PingInvertTransition *)pingInvertTransition
{
    if (!_pingInvertTransition) {
        _pingInvertTransition = [[PingInvertTransition alloc] init];
    }
    return _pingInvertTransition;
}

@end

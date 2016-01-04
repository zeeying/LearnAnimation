//
//  ViewController.m
//  AnimatedCurveDemo
//
//  Created by 曾哲影 on 15/12/27.
//  Copyright © 2015年 zengzheying. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Convenient.h"

#import "KYPullToCurveView.h"
#import "KYPullToCurveView_footer.h"

#define initialOffset 50.0

#define targetHeight 500.0

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
    UILabel *navTitle;
    UIView *bkView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    [self.tableView layoutIfNeeded];
    
    bkView = [[UIView alloc] init];
    bkView.center = CGPointMake(self.view.center.x, 22);
    bkView.bounds = CGRectMake(0, 0, 250, 44);
    bkView.clipsToBounds = YES;
    [self.navigationController.navigationBar addSubview:bkView];
    
    navTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 + initialOffset, bkView.frame.size.width, 44)];
    navTitle.alpha = 0;
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor blackColor];
    navTitle.text = @"Fade in/out navbar title";
    [bkView addSubview:navTitle];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat transitionY = MIN(MAX(0, scrollView.contentOffset.y + 64), 44 + initialOffset + targetHeight);
//    NSLog(@"%f", transitionY);
    if (transitionY <= initialOffset) {
        navTitle.frame = CGRectMake(0, 44 + initialOffset - transitionY, bkView.frame.size.width, 44);
    } else {
        CGFloat factor = MAX(0, MIN(1, (transitionY - initialOffset) / targetHeight));
        navTitle.frame = CGRectMake(0, 44 - factor * 44, bkView.frame.size.width, 44);
        navTitle.alpha = factor * factor * 1;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    KYPullToCurveView *headerView = [[KYPullToCurveView alloc] initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
    
    __weak KYPullToCurveView *weakHeaderView = headerView;
    
    [headerView triggerPulling];
    
    [headerView addRefreshingBlock:^{
        //具体的操作
        //...
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakHeaderView stopRefreshing];
        });
    }];
    
    KYPullToCurveView_footer *footerView = [[KYPullToCurveView_footer alloc] initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
    
    __weak KYPullToCurveView_footer *weakFooterView = footerView;
    
    [footerView addRefreshingBlock:^{
        double delayInSeconds =2.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            KYPullToCurveView_footer *view = weakFooterView;
            [view stopRefreshing];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *testCell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    testCell.textLabel.text = [NSString stringWithFormat:@"第%ld条", (long)indexPath.row];
    return testCell;
}

@end
;
//
//  ViewController.m
//  GooeySlideMenuDemo
//
//  Created by zengzheying on 15/12/16.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import "ViewController.h"
#import "GooeySlideMenu.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
    GooeySlideMenu *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    menu = [[GooeySlideMenu alloc] initWithTitles:@[@"首页",@"消息",@"发布",@"发现",@"个人",@"设置"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTrigger:(id)sender
{
    [menu trigger];
}

#pragma mark -- UITabel View Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"NO.%ld",(long)indexPath.row];
    
    return cell;
}
@end

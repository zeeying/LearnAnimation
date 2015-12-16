//
//  SlideMenuButton.h
//  GooeySlideMenuDemo
//
//  Created by zengzheying on 15/12/16.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuButton : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic, strong) UIColor *buttonColor;

@property (nonatomic, copy) void(^buttonClickBlock)(void);

@end

//
//  GooeySlideMenu.h
//  GooeySlideMenuDemo
//
//  Created by zengzheying on 15/12/16.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuButtonClickdBlock)(NSInteger index, NSString *title, NSInteger titleCounts);

@interface GooeySlideMenu : UIView

@property (nonatomic, assign) CGFloat menuButtonHeight;
@property (nonatomic, copy) MenuButtonClickdBlock menuClickBlock;

- (instancetype)initWithTitles:(NSArray *)titles;

- (instancetype)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;

- (void)trigger;

@end

//
//  JumpStarView.h
//  JumpStarAnimation
//
//  Created by zengzheying on 15/12/17.
//  Copyright (c) 2015年 zengzheying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    non_Mark,
    Mark,
} STATE;



@interface JumpStarView : UIView

- (void)animate;

@property (nonatomic, assign, setter=setState:) STATE state;
@property (nonatomic, strong) UIImage *markedImage;
@property (nonatomic, strong) UIImage *non_markedImage;

@end

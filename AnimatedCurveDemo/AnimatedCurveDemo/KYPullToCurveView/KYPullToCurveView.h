//
//  KYPullToCurveView.h
//  AnimatedCurveDemo
//
//  Created by 曾哲影 on 15/12/27.
//  Copyright © 2015年 zengzheying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYPullToCurveView : UIView

/**
 *  需要滑动多少距离才能松开
 */
@property (nonatomic, assign) CGFloat pullDistance;

/**
 *  初始化方法
 *
 *  @param scrollView 关联的滚动视图
 *
 *  @return self
 */
- (instancetype)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar;


/**
 *  立即触发下拉刷新
 */
- (void)triggerPulling;

/**
 *  停止旋转，并且滚动视图回弹到顶部
 */
- (void)stopRefreshing;

/**
 *  刷新执行的具体操作
 *
 *  @param block 操作
 */
- (void)addRefreshingBlock:(void (^)(void))block;


@end

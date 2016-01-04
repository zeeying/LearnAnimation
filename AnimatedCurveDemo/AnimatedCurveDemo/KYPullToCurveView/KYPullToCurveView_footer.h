//
//  KYPullToCurveView_footer.h
//  AnimatedCurveDemo
//
//  Created by 曾哲影 on 16/1/3.
//  Copyright © 2016年 zengzheying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYPullToCurveView_footer : UIView

/**
 *  需要滑动多大距离才能松开
 */
@property (nonatomic, assign) CGFloat pullDistance;

/**
 *  初始化方法
 *
 *  @param scrollView 关联的滚动视图
 *  @param navBar     是否有NavigationBar
 *
 *  @return self
 */
- (instancetype)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar;

/**
 *  停止旋转，并且滚动视图回弹到底部
 */
- (void)stopRefreshing;

/**
 *  刷新执行的具体操作
 *
 *  @param block 操作
 */
- (void)addRefreshingBlock:(void (^)(void))block;
@end

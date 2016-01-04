//
//  CurveView.m
//  AnimatedCurveDemo
//
//  Created by 曾哲影 on 15/12/27.
//  Copyright © 2015年 zengzheying. All rights reserved.
//

#import "CurveView.h"
#import "CurveLayer.h"

@interface CurveView ()

@property (nonatomic, strong) CurveLayer *curveLayer;

@end

@implementation CurveView

+ (Class)layerClass {
    return [CurveLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress {
    self.curveLayer.progress = progress;
    [self.curveLayer setNeedsDisplay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.curveLayer = [CurveLayer layer];
    self.curveLayer.frame = self.bounds;
    self.curveLayer.contentsScale = [UIScreen mainScreen].scale;
    self.curveLayer.progress = 0.0f;
    [self.curveLayer setNeedsDisplay];
    [self.layer addSublayer:self.curveLayer];
}

@end

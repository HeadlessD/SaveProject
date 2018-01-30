//
//  HMSMonitorSleepProportionView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/26.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMonitorSleepProportionView.h"

@implementation HMSMonitorSleepProportionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.backgroundColor =[UIColor whiteColor];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
    lineView.backgroundColor = HMSThemeDeviderColor;
    [self addSubview:lineView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end

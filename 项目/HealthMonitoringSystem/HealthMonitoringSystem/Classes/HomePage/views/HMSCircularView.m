//
//  HMSCircularView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/18.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSCircularView.h"

@implementation HMSCircularView


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end

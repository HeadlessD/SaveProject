//
//  HMSSleepPercentView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSSleepPercentView : UIView
@property (nonatomic,strong) UIColor    *lineColor;
@property (nonatomic,assign) float      percent;

-(void)reloadViewWithPercent:(float)percent;
-(void)reloadViewWithPercent:(float)percent withStartAngle:(CGFloat)startAngle;
@end

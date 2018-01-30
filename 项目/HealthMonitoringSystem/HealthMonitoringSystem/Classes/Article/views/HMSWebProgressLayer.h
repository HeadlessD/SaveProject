//
//  HMSWebProgressLayer.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/27.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HMSWebProgressLayer : CAShapeLayer
@property (nonatomic,strong)UIColor *lineColor;
- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;
@end

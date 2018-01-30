//
//  HMSMonitorRealTimeView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSMonitorRealTimeView : UIView
+(instancetype)monitorRealTimeView;

@property (weak, nonatomic) IBOutlet UILabel *heartRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *breatheLabel;

@property (weak, nonatomic) IBOutlet UILabel *bodyMoveLabel;
@end

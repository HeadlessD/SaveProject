//
//  HMSMonitorRealTimeView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMonitorRealTimeView.h"

@interface HMSMonitorRealTimeView ()


@end
@implementation HMSMonitorRealTimeView

+(instancetype)monitorRealTimeView{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMSMonitorRealTimeView"
                                          owner:nil options:nil]lastObject];
}



@end

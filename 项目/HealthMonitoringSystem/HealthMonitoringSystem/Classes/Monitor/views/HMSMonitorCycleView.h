//
//  HMSMonitorCycleView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/26.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMSDayReportModel;
@interface HMSMonitorCycleView : UIView
+(instancetype)monitorCycleView;
@property (nonatomic,strong) HMSDayReportModel *dayReportM;
@end

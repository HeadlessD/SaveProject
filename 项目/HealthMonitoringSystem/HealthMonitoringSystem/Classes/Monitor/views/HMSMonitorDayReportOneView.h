//
//  HMSMonitorDayReportOneView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSDayReportModel;
@interface HMSMonitorDayReportOneView : UIView

+(instancetype)monitorDayReportOneView;

@property (nonatomic,strong) HMSDayReportModel *dayReportM;
@end

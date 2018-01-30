//
//  HMSDayReportModel.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/26.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSDayReportModel.h"
#import <MJExtension.h>
@implementation HMSDayReportModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"sleep_data":@"HMSSleep_dataModel",@"breath_data":@"HMSTemp_dataModel",@"heart_beat_data":@"HMSTemp_dataModel",@"body_move_data":@"HMSTemp_dataModel"};
}
@end

@implementation HMSSleep_dataModel
@end

@implementation HMSTemp_dataModel
@end

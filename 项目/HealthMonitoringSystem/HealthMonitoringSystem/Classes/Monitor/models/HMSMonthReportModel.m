//
//  HMSMonthReportModel.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/27.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMonthReportModel.h"
#import <MJExtension.h>

@implementation HMSMonthReportModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"month_sleep_data":@"HMSMonth_sleep_dataModel"};
}
@end

@implementation HMSMonth_sleep_dataModel

@end

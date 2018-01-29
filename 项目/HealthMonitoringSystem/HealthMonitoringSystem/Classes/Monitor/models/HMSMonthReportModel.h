//
//  HMSMonthReportModel.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/27.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSMonth_sleep_dataModel;
@interface HMSMonthReportModel : NSObject
//int	老人id
@property (nonatomic,copy) NSString *member_id;
//string	日期,例:2017-07-25
@property (nonatomic,copy) NSString *date;
//string	报告类型,例:daily,weekly,month
@property (nonatomic,copy) NSString *report_type;
//string	睡眠最好的一天,例:2017-07-25
@property (nonatomic,copy) NSString *best_day;
//int	平均深睡眠占总睡眠时间,例:20
@property (nonatomic,copy) NSString *deep_percentage_avg;
//array	一个月的睡眠数据
@property (nonatomic,copy) NSArray <HMSMonth_sleep_dataModel *>*month_sleep_data;


@end


@interface HMSMonth_sleep_dataModel : NSObject
//string	日期,例:2017-07-25
@property (nonatomic,copy) NSString *day;
//int	睡眠时间,单位:minute
@property (nonatomic,assign) NSInteger sleep_duration_minute;
//int	深睡眠时间,单位:minute
@property (nonatomic,assign) NSInteger deep_duration_minute;



@end

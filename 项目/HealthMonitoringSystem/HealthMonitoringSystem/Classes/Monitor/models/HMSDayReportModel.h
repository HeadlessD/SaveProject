//
//  HMSDayReportModel.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/26.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSSleep_dataModel,HMSTemp_dataModel;
@interface HMSDayReportModel : NSObject
//	int	分数
@property (nonatomic,copy) NSString *score;
//	int	老人id
@property (nonatomic,copy) NSString *member_id;
//	string	日期,例:2017-07-25
@property (nonatomic,copy) NSString *date;
//	string	报告类型,例:daily,weekly,month
@property (nonatomic,copy) NSString *report_type;
//	string	睡眠状态:normal,good,subpar
@property (nonatomic,copy) NSString *sleep_status;
//	string	例:21:00
@property (nonatomic,copy) NSString *sleep_start;
//string	趋势,up,down,constant
@property (nonatomic,copy) NSString *sleep_start_tend;
//int	睡眠持续时间,单位:minute
@property (nonatomic,copy) NSString *sleep_duration_minute;
//string	趋势,up,down,constant
@property (nonatomic,copy) NSString *sleep_duration_minute_tend;
//int	进入睡眠时间
@property (nonatomic,copy) NSString *fall_sleep_minute;
//string	趋势,up,down,constant
@property (nonatomic,copy) NSString *fall_sleep_minute_tend;
//int	床上时间,单位:minute
@property (nonatomic,copy) NSString *on_bed_duration_minute;
//string	趋势,up,down,constant
@property (nonatomic,copy) NSString *on_bed_duration_minute_tend;
//int	分数打败别人百分比,例:80
@property (nonatomic,copy) NSString *beat_percentage;
//array	睡眠数据
@property (nonatomic,copy) NSArray <HMSSleep_dataModel *>*sleep_data;
//int	深睡眠占比
@property (nonatomic,copy) NSString *deep_percentage;
//int	rem睡眠时间占比,例:26
@property (nonatomic,copy) NSString *rem_percentage;
//int	浅睡眠时间占比,例:30
@property (nonatomic,copy) NSString *light_percentage;
//int	清醒时间占比,例:20
@property (nonatomic,copy) NSString *awake_percentage;
//int	平均呼吸频率
@property (nonatomic,copy) NSString *breath_avg;
//int	平均心率
@property (nonatomic,copy) NSString *heart_beat_avg;
//int	体动数
@property (nonatomic,copy) NSString *body_move_times;
//array	呼吸数据
@property (nonatomic,copy) NSArray <HMSTemp_dataModel *>*breath_data;
//array	心率数据
@property (nonatomic,copy) NSArray <HMSTemp_dataModel *>*heart_beat_data;
//array	体动数据
@property (nonatomic,copy) NSArray <HMSTemp_dataModel *>*body_move_data;

@end


@interface HMSSleep_dataModel : NSObject

//int	开始时间,例:1500373381
@property (nonatomic,copy) NSString *start;
//int	结束时间,例:1500373381
@property (nonatomic,copy) NSString *end;
//int	睡眠情况,1:deep,2:light,3:rem,4:wake,5:leave
@property (nonatomic,assign) NSInteger status;
@end


@interface HMSTemp_dataModel : NSObject
//时刻,例:23
@property (nonatomic,copy) NSString *time;
//int	心率数据
@property (nonatomic,assign) NSInteger value;

@end



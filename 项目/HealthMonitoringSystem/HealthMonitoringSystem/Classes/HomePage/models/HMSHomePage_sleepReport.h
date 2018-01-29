//
//  HMSHomePage_sleepReport.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/24.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HMSHomePage_sleepReport : NSObject
//老人id
@property (nonatomic,strong) NSString *member_id;
//睡眠得分
@property (nonatomic,strong) NSString *score;
//睡眠开始时间,例:21:00
@property (nonatomic,strong) NSString *sleep_start;
//睡眠结束时间,例:07:22
@property (nonatomic,strong) NSString *sleep_end;
//深睡眠时间占比
@property (nonatomic,strong) NSString *deep_percentage;
//rem睡眠时间占比
@property (nonatomic,strong) NSString *rem_percentage;
//浅睡眠时间占比
@property (nonatomic,strong) NSString *light_percentage;
//清醒时间占比
@property (nonatomic,strong) NSString *awake_percentage;
//睡眠状态 睡眠状态:normal,good,subpar
@property (nonatomic,strong) NSString *sleep_status;
@end

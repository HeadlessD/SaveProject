//
//  HMSArticleModel.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSArticleModel.h"
#import <MJExtension.h>
#import "NSDate+Escort.h"

@implementation HMSArticleModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"articleId":@"id"};
}

-(void)setCollect_count:(NSString *)collect_count
{
    //    collect_count = [NSString stringWithFormat:@"%d",arc4random_uniform(100000)] ;
    if ([collect_count integerValue]>10000) {
        _collect_count =[NSString stringWithFormat:@"%.2f万",[collect_count integerValue]/10000.00];
    }else
    {
        _collect_count =collect_count;
    }
}
-(void)setTime_created:(NSString *)time_created
{
    _time_created = time_created;
    //    NSTimeInterval time = [time_created doubleValue] +28800; //因为时差问题要加8小时== 28800秒
    //
    //    NSDate * detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time_created doubleValue]]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *detaildate = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    if (detaildate.deltaToNow.year>0) {
        _timeStr =[NSString stringWithFormat:@"%ld年前", detaildate.deltaToNow.year];
    }else if (detaildate.deltaToNow.month>0)
    {
        _timeStr =[NSString stringWithFormat:@"%ld月前", detaildate.deltaToNow.month];
    }else if (detaildate.deltaToNow.day>0)
    {
        _timeStr =[NSString stringWithFormat:@"%ld天前", detaildate.deltaToNow.day];
    }else
    {
        if (detaildate.deltaToNow.hour >= 1) { // 1个小时以前
            _timeStr =[NSString stringWithFormat:@"%ld小时前", detaildate.deltaToNow.hour];
        } else if (detaildate.deltaToNow.minute >= 1) { // 1分钟以前
            _timeStr =[NSString stringWithFormat:@"%ld分钟前", detaildate.deltaToNow.minute];
        } else { // 1分钟以内
            _timeStr = @"刚刚";
        }
    }
    
}

@end

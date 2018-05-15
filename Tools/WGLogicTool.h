//
//  WGLogicTool.h
//  HealthMonitoringSystem
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGLogicTool : NSObject
+(void)changeRootVCtoLoginVC;
+ (void)changeRootVCtoHomeVC;
//获取 Token
+(NSMutableArray *)getHttpTokenAndReqtime;

//生成属性
+ (void)nslogPropertyWithDic:(id)obj;


@end

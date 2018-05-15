//
//  HMSUpDateAppTool.h
//  HealthMonitoringSystem
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSUpDateAppTool : NSObject
/**
 检测程序更新
 
 @param appid  来自程序id
 @param block block回调
 */
+(void)hs_updateWithAPPID:(NSString *)appid error:(void(^)(NSString *error))error block:(void(^)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,BOOL isUpdate))block;

@end

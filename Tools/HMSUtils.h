//
//  HMSUtils.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/3.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSUtils : NSObject
+(void)changeRootVCtoLoginVC;
+ (void)changeRootVCtoHomeVC;

//正则匹配
+ (BOOL)userNameIsPhone:(NSString*)string;
+ (BOOL)userNameIsEmail:(NSString*)string;
+ (BOOL)userPwdLengthMatch:(NSString*)string;
+ (BOOL)checkQQNumber:(NSString *)string;
+ (BOOL)checkIfAppInstalled:(NSString *)urlSchemes;


//urlecoding
+(NSString *)escapedString:(NSString *)string;


+ (NSString*)weekdayStringFromDate:(NSString*)inputDate;
@end

//
//  HMSUtils.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/3.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSUtils.h"
#import "HMSLoginVC.h"
#import "HMSCustomNavigationVC.h"
#import "HMSMainTabbarController.h"
@implementation HMSUtils


+(void)changeRootVCtoLoginVC
{
    AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    HMSLoginVC *loginVC =[[HMSLoginVC alloc]init];
    delegate.window.rootViewController =[[HMSCustomNavigationVC alloc]initWithRootViewController:loginVC];
}


+ (void)changeRootVCtoHomeVC{
    AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    HMSMainTabbarController *tabbarVC =[[HMSMainTabbarController alloc]init];
    delegate.window.rootViewController =tabbarVC;
}


+ (BOOL)userNameIsPhone:(NSString*)string{
    NSString *regexPhone =[NSString stringWithFormat:@"^(1[3,4,5,7,8][0-9])\\d{8}$"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexPhone];
    BOOL phoneNumberMatch = [predicate evaluateWithObject:string];
    return phoneNumberMatch;
}
+ (BOOL)userNameIsEmail:(NSString*)string{
    NSString *regex =[NSString stringWithFormat:@"[A-Z0-9a-z.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [predicate evaluateWithObject:string];
    return isMatch;
}
+ (BOOL)checkQQNumber:(NSString *)string
{
    NSString *regex =[NSString stringWithFormat:@"[1-9][0-9]{4,14}"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [predicate evaluateWithObject:string];
    return isMatch;
}
+ (BOOL)userPwdLengthMatch:(NSString*)string{
    NSString *regexPwd =[NSString stringWithFormat:@"[a-zA-Z0-9_]{6,20}"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexPwd];
    BOOL pwdMatch = [predicate evaluateWithObject:string];
    return pwdMatch;
}


+ (BOOL)checkIfAppInstalled:(NSString *)urlSchemes
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]])
    {
        return  YES;
    }
    else
    {
        return  NO;
    }
}



//urlecoding
+(NSString *)escapedString:(NSString *)string{
    NSString *unescaped = string;
    NSString *escapedString = [unescaped stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    return escapedString;
}



+ (NSString*)weekdayStringFromDate:(NSString*)inputDate {
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputD =[dateFormtter dateFromString:inputDate];
    
    NSInteger interval = [timeZone secondsFromGMTForDate: inputD];
    NSDate *localeDate = [inputD  dateByAddingTimeInterval: interval];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"日", @"一",@"二", @"三", @"四", @"五", @"六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday|NSCalendarUnitDay;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:localeDate];
    //    NSDate *today = [[NSDate alloc] init];
    //    NSString * todayString = [[today description] substringToIndex:10];
    //    NSString * dateString = [[localeDate description] substringToIndex:10];
    //
    //    if ([dateString isEqualToString:todayString])
    //    {
    //        return @"今";
    //    }else
    //    {
    //        return [weekdays objectAtIndex:theComponents.weekday];
    //    }
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end

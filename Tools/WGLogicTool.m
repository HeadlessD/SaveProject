//
//  WGLogicTool.m
//  HealthMonitoringSystem
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import "WGLogicTool.h"
#import "WGLoginViewController.h"
//#import "HMSCustomNavigationVC.h"
#import "WGTabBarController.h"
@implementation WGLogicTool


+(void)changeRootVCtoLoginVC
{
    AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    WGLoginViewController *loginVC =[[WGLoginViewController alloc]init];
    delegate.window.rootViewController = loginVC;
    
    //    delegate.window.rootViewController = [[HMSCustomNavigationVC alloc]initWithRootViewController:loginVC];
}

+ (void)changeRootVCtoHomeVC{
    AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    WGTabBarController *tabbarVC = [[WGTabBarController alloc]init];
    delegate.window.rootViewController = tabbarVC;
}



+(NSMutableArray *)getHttpTokenAndReqtime{
    
    NSMutableArray * timeArr = [NSMutableArray array];

    //设定时间格式,这里可以设置成自己需要的格式
    NSDateFormatter * matter = [[NSDateFormatter alloc]init];
    [matter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString * reqtime = [matter stringFromDate:date];
    
    
    //字符串转时间戳 如：2017-4-10 17:15:10
    NSDate *tempDate = [matter dateFromString:reqtime];//将字符串转换为时间对象
    NSTimeInterval timeInt = [tempDate timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    timeInt = timeInt * 1000 + 508;
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)timeInt];//字符串转成时间戳,精确到毫秒*1000
    NSString * tokenAdd = [@"AvantecH@SamplE$$" stringByAppendingString:timeStr];
    NSString * token = [[tokenAdd MD5Hash] MD5Hash];
    
//    WGLog(@"\n请求时间：%@,\ntimeStr：%@，\ntoken：%@",reqtime,tokenAdd,token);
    
    [timeArr addObject:token];
    [timeArr addObject:reqtime];
    
    return timeArr;
}


+ (void)nslogPropertyWithDic:(id)obj {
    
#if DEBUG
    
    NSDictionary *dic = [NSDictionary new];
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = [(NSDictionary *)obj mutableCopy];
        dic = tempDic;
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *tempArr = [(NSArray *)obj mutableCopy];
        if (tempArr.count > 0) {
            dic = tempArr[0];
        } else {
            NSLog(@"无法解析为model属性，因为数组为空");
            return;
        }
    } else {
        NSLog(@"无法解析为model属性，因为并非数组或字典");
        return;
    }
    
    if (dic.count == 0) {
        NSLog(@"无法解析为model属性，因为该字典为空");
        return;
    }
    
    
    NSMutableString *strM = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *className = NSStringFromClass([obj class]) ;
        NSLog(@"className:%@/n", className);
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"] |
                  [className isEqualToString:@"__NSArray0"] |
                  [className isEqualToString:@"__NSArrayI"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSDictionary *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic, assign) BOOL   %@;\n",key];
        }else if ([className isEqualToString:@"NSDecimalNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"NSNull"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }else if ([className isEqualToString:@"__NSArrayM"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        
    }];
    NSLog(@"\n%@\n",strM);
    
#endif
    
}

@end

//
//  HMSQiniuUploadHelper.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/18.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSQiniuUploadHelper.h"

@implementation HMSQiniuUploadHelper

static id _instance = nil;
+ (id)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedUploadHelper {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}
@end

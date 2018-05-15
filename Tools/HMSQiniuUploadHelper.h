//
//  HMSQiniuUploadHelper.h
//  HealthMonitoringSystem
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSQiniuUploadHelper : NSObject
@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *);
@property (copy, nonatomic)  void (^singleFailureBlock)(NSString *);

+ (instancetype)sharedUploadHelper;
@end

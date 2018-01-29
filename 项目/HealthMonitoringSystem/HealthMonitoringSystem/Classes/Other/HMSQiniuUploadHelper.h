//
//  HMSQiniuUploadHelper.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/18.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSQiniuUploadHelper : NSObject
@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *);
@property (copy, nonatomic)  void (^singleFailureBlock)(NSString *);

+ (instancetype)sharedUploadHelper;
@end

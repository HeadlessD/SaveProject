//
//  HMSPersonlInfoVC.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/5.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSBaseVC.h"
typedef enum
{
    HMSPersonlInfoVCPushBtnTypeOne,
    HMSPersonlInfoVCPushBtnTypeTwo
}HMSPersonlInfoVCPushBtnType;

typedef void (^HMSPersonlInfoVCBlock)();

@interface HMSPersonlInfoVC : HMSBaseVC

@property (nonatomic,copy)HMSPersonlInfoVCBlock dissmissVC;

@end

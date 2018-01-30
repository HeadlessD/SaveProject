//
//  HMSReleaseCircleOFFriendVC.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/17.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSBaseVC.h"

typedef enum{
    HMSReleaseCircleOFFriendVCCamera,
    HMSReleaseCircleOFFriendVCImageText,
    HMSReleaseCircleOFFriendVCText
} HMSReleaseCircleOFFriendVCType;

typedef void (^HMSReleaseCircleOFFriendVCAction)(void);
@interface HMSReleaseCircleOFFriendVC : HMSBaseVC

@property (nonatomic,assign)HMSReleaseCircleOFFriendVCType releaseVCType;

@property (nonatomic,strong)UIImage *typeOneImg;

@property (nonatomic,copy) HMSReleaseCircleOFFriendVCAction controllerDismiss;
@end

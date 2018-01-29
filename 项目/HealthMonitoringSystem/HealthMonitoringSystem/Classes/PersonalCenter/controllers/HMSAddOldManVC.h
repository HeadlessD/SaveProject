//
//  HMSAddOldManVC.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSBaseVC.h"

typedef void(^HMSAddOldManVCAction)(void);
@class HMSOldManModel;
@interface HMSAddOldManVC : HMSBaseVC

@property (nonatomic,copy) HMSAddOldManVCAction controllerDismiss;
@property (nonatomic,strong) HMSOldManModel *oldMan;
@end

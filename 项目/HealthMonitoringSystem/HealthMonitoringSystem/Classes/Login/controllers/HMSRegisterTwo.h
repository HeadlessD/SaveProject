//
//  HMSRegisterTwo.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/30.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSBaseVC.h"

typedef enum
{
    HMSRegisterTwoTypeLoginFirst,
    HMSRegisterTwoTypeRegist
}HMSRegisterTwoType;
@interface HMSRegisterTwo : HMSBaseVC
@property (nonatomic,strong)NSString *phoneNumber;
@property (nonatomic,assign)HMSRegisterTwoType pageType;
@end

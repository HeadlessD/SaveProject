//
//  HMSSelectAddressVC.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/18.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSBaseVC.h"

typedef void(^HMSSelectAddressVCSelectAddress)(NSString *);
@interface HMSSelectAddressVC : HMSBaseVC
@property (nonatomic,strong)NSString *currentAddress;

@property (nonatomic,copy)HMSSelectAddressVCSelectAddress selectAddress;
@end

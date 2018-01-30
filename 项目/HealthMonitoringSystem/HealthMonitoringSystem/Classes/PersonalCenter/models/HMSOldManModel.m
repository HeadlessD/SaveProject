//
//  HMSOldManModel.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSOldManModel.h"
#import <MJExtension.h>
@implementation HMSOldManModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"oldMan_id":@"id",@"device_id":@"new_device_id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"friend_relative_group":@"HMSOldManFriendModel"};
}
@end


@implementation HMSOldManFriendModel

@end

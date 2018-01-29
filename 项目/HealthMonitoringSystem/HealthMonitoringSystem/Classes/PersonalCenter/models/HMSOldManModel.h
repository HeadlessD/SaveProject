//
//  HMSOldManModel.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMSOldManFriendModel;
@interface HMSOldManModel : NSObject

//老人id
@property (nonatomic,strong) NSString *oldMan_id;
//新建老人用户的id
@property (nonatomic,strong) NSString *user_id;
//老人名称
@property (nonatomic,strong) NSString *name;
//老人性别0男1女
@property (nonatomic,strong) NSString *sex;
//老人出生日期
@property (nonatomic,strong) NSString *birthday;
//老人手机号
@property (nonatomic,strong) NSString *mobile;
//病史
@property (nonatomic,strong) NSString *disease_history;

//角色
@property (nonatomic,strong) NSString *role;
//头像
@property (nonatomic,strong) NSString *avatar;
//亲友团数组
@property (nonatomic,strong) NSArray *friend_relative_group;
@end

@interface HMSOldManFriendModel : NSObject
//亲友团表的id
@property (nonatomic,strong) NSString *friend_table_id;
//头像
@property (nonatomic,strong) NSString *avatar;
//名称
@property (nonatomic,strong) NSString *username;
//性别0男1女
@property (nonatomic,strong) NSString *sex;
//性别0男1女
@property (nonatomic,strong) NSString *birthday;
@end

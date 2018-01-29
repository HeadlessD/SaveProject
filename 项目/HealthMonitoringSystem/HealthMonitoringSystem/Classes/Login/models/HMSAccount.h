//
//  HMSAccount.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSAccount : NSObject<NSCoding>
/**用户 ID*/
@property (nonatomic, strong) NSString *user_id;
/**用户 ID*/
@property (nonatomic, strong) NSString *account_id;
/**用户头像*/
@property (nonatomic, strong) NSString *avatar;
/**用户昵称*/
@property (nonatomic, strong) NSString *username;
//0:没有初始化,1:已经初始化
@property (nonatomic, strong) NSString *is_inited;
//会话id
@property (nonatomic, strong) NSString *session_id;

@property (nonatomic, strong) NSString *mobile;
//sex	int	性别0:男,1:女
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *birthday;

+(instancetype)shareAccount;

-(void)save;
-(void)loginOut;

-(void)getUserInfoSuccess:(void (^)(void))success failure:(void (^)(NSString *error))failure;

@end

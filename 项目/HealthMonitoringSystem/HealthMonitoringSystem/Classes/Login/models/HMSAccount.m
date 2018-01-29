//
//  HMSAccount.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSAccount.h"
#import <MJExtension.h>
#define HMSAccountKey @"HMSAccountKey.test"
@implementation HMSAccount
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"account_id":@"id"};
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.is_inited forKey:@"is_inited"];
    [aCoder encodeObject:self.session_id forKey:@"session_id"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.is_inited = [aDecoder decodeObjectForKey:@"is_inited"];
        self.session_id = [aDecoder decodeObjectForKey:@"session_id"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
    
    }
    return self;
}

+(instancetype)shareAccount
{
//    HMSAccount *account =[[self alloc]init];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    
//    NSData *data = [user objectForKey:HMSAccountKey];
//    
//    account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path=[docPath stringByAppendingPathComponent:HMSAccountKey];
    HMSAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return account;
}

//+(instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static HMSAccount *account;
//    static dispatch_once_t once;
//    
//    dispatch_once(&once, ^{
//        if (account==nil) {
//            account =[super allocWithZone:zone];
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            
//            NSData *data = [user objectForKey:HMSAccountKey];
//            
//            account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        }
//    });
//    return account;
//}


-(void)save
{
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
//    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:data forKey:HMSAccountKey];
//    [user synchronize];
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path=[docPath stringByAppendingPathComponent:HMSAccountKey];
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}
-(void)loginOut
{
    [HMSNetWorkManager requestJsonDataWithPath:@"user/logout" withParams:nil withMethodType:HttpRequestTypePost success:nil failure:nil];
    
    self.user_id = nil;
    self.avatar = nil;
    self.username = nil;
    self.is_inited = nil;
    self.session_id = nil;
    self.mobile = nil;
    self.sex = nil;
    self.birthday = nil;
    
    [self save];
}

-(void)getUserInfoSuccess:(void (^)(void))success failure:(void (^)(NSString *error))failure;
{
    
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"user/get-user-info" withParams:nil withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            HMSAccount *account= [HMSAccount mj_objectWithKeyValues:respondObj[@"data"]];
            self.mobile = account.mobile;
            self.sex = account.sex;
            self.birthday = account.birthday;
            self.avatar = account.avatar;
            self.user_id = account.account_id;
            self.is_inited = account.is_inited;
            self.username = account.username;
            
            [self save];
            if (success) {
                success();
            }
        }else{
            if (failure) {
                failure(error_message);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(@"网络错误,请重试");
        }
    }];
}


@end

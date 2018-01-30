//
//  UP_NetAPIClicnet.h
//  优屏
//
//  Created by 高炜 on 16/6/14.
//  Copyright © 2016年 上海霓玺科技有限公司. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;
@interface UP_NetAPIClicnet : AFHTTPSessionManager
+ (UP_NetAPIClicnet *)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataNoHUDWithPath:(NSString *)aPath
                          withParams:(NSDictionary*)params
                      withMethodType:(int)NetworkMethod
                            andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataHUDFORCreateOrdersWithPath:(NSString *)aPath
                                       withParams:(NSDictionary*)params
                                   withMethodType:(int)NetworkMethod
                                         andBlock:(void (^)(id data, NSError *error))block;
@end

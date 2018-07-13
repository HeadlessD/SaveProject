//
//  WGNetClicnet.h
//  优屏
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;
@interface WGNetClicnet : AFHTTPSessionManager
+ (WGNetClicnet *)sharedJsonClient;

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

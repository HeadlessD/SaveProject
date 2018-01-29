//
//  UP_NetAPIClicnet.m
//  优屏
//
//  Created by 高炜 on 16/6/14.
//  Copyright © 2016年 上海霓玺科技有限公司. All rights reserved.
//

#import "UP_NetAPIClicnet.h"

@implementation UP_NetAPIClicnet

+ (UP_NetAPIClicnet *)sharedJsonClient {
    static UP_NetAPIClicnet *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[UP_NetAPIClicnet alloc] initWithBaseURL:[NSURL URLWithString:HMSTestBaseUrl]];
        
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/javascript", @"text/json", nil];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.securityPolicy.allowInvalidCertificates = YES;
    
   
    
    return self;
}

- (void)requestJsonDataHUDFORCreateOrdersWithPath:(NSString *)aPath
                                       withParams:(NSDictionary*)params
                                   withMethodType:(int)NetworkMethod
                                         andBlock:(void (^)(id data, NSError *error))block{
    //log请求数据
    DebugLog(@"\n===========request===========\n%@    \n%@", aPath, params);
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    [MBProgressHUD showMessage:@"正在验证支付..." toView:[[UIApplication sharedApplication].delegate window]];
    
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                     block(responseObject, nil);
                }
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
      
            break;
        }
        case Post:{
            
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            
            break;}
        case Put:{
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            break;}
        case Delete:{
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            ;}
        default:
            break;
    }
}





- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block{
    //log请求数据
    DebugLog(@"\n===========request===========\n%@    \n%@", aPath, params);
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    [MBProgressHUD showMessage:DEF_ALERTMESSAGE toView:[[UIApplication sharedApplication].delegate window]];
    
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            break;
        }
        case Post:{
            
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            
            break;}
        case Put:{
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            break;}
        case Delete:{
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            ;}
        default:
            break;
    }
}


- (void)requestJsonDataNoHUDWithPath:(NSString *)aPath
                          withParams:(NSDictionary*)params
                      withMethodType:(int)NetworkMethod
                            andBlock:(void (^)(id data, NSError *error))block{
    //log请求数据
    DebugLog(@"\n===========request===========\n%@    \n%@", aPath, params);
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            break;
        }
        case Post:{
            
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            
            break;}
        case Put:{
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            break;}
        case Delete:{
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@ \n%@ repMsg = %@", aPath, responseObject,[responseObject objectForKey:@"repMsg"]);
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@ \n%@", aPath, error);
                block(nil, error);
            }];
            
            ;}
        default:
            break;
    }
}


@end

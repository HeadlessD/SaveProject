//
//  HMSNetWorkManager.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/29.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSNetWorkManager.h"

#import "HMSQiniuUploadHelper.h"

@implementation HMSNetWorkManager

+ (HMSNetWorkManager *)shareManger {
    static HMSNetWorkManager *_shareManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareManger = [[HMSNetWorkManager alloc] initWithBaseURL:[NSURL URLWithString:HMSTestBaseUrl]];
        
    });
    
    return _shareManger;
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
     self.requestSerializer.timeoutInterval = 20;
    
    return self;
}


+ (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(HttpRequestType)requestType
                        success:(void (^)(id respondObj))success failure:(void (^)(NSError *error))failure
{
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[HMSNetWorkManager shareManger].requestSerializer setValue:[NSString stringWithFormat:@"session_id=%@",[HMSAccount shareAccount].session_id] forHTTPHeaderField:@"Cookie"];
    
    switch (requestType) {
        case HttpRequestTypeGet:
        {
            [[HMSNetWorkManager shareManger] GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    
                    NSString *error = [responseObject objectForKey:@"error"];
                    if ([error isEqualToString:@"please_login"]) {
                        [SVProgressHUD showInfoWithStatus:@"登录信息过期，请重新登录"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [[HMSAccount shareAccount]loginOut];
                            [HMSUtils changeRootVCtoLoginVC];
                        });
                        return ;
                    }
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    
                    failure(error);
                }
            }];
            
        break;}
            
        case HttpRequestTypePost:
        {
            [[HMSNetWorkManager shareManger] POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (success) {
                    
                    NSString *error = [responseObject objectForKey:@"error"];
                    if ([error isEqualToString:@"please_login"]) {
                        [SVProgressHUD showInfoWithStatus:@"登录信息过期，请重新登录"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [[HMSAccount shareAccount]loginOut];
                            [HMSUtils changeRootVCtoLoginVC];
                        });
                        return ;
                    }
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
            break;}
            
        default:
            break;
    }
}


+ (void)requestJsonDataWithOutBaseUrlPath:(NSString *)aPath
                               withParams:(NSDictionary*)params
                           withMethodType:(HttpRequestType)requestType
                                  success:(void (^)(id respondObj))success failure:(void (^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval =10.0;
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",
     @"text/html", nil];
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    switch (requestType) {
        case HttpRequestTypeGet:
        {
            [manager GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    
                    failure(error);
                }
            }];
            
            break;}
            
        case HttpRequestTypePost:
        {
            [manager POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (success) {
                    
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
            break;}
            
        default:
            break;
    }
}





+ (void)uploadImages:(NSArray*)imageArray progress:(void(^)(CGFloat))progress success:(void(^)(NSArray*))success failure:(void(^)(NSString*))failure

{
    
    NSMutableArray*array = [[NSMutableArray alloc]init];
    
    __block CGFloat totalProgress =0.0f;
    
    __block CGFloat partProgress =1.0f/ [imageArray count];
    
    __block NSUInteger currentIndex =0;
    
    HMSQiniuUploadHelper *uploadHelper = [HMSQiniuUploadHelper sharedUploadHelper];
    
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock= ^(NSString*error) {
        
        failure(error);
        
        return;
        
    };
    
    uploadHelper.singleSuccessBlock= ^(NSString*url) {
        
        [array addObject:url];
        
        totalProgress += partProgress;
        
        progress(totalProgress);
        
        currentIndex++;
        
        if([array count] == [imageArray count]) {
            
            success([array copy]);
            
            return;
            
        }else{
            
            NSLog(@"---%ld",currentIndex);
            
            [HMSNetWorkManager uploadImage:imageArray[currentIndex] progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
            
        }
        
    };
    
    [HMSNetWorkManager uploadImage:imageArray[0] progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
    
}


+ (void)uploadImage:(UIImage *)image progress:(QNUpProgressHandler)progress success:(void (^)(NSString *url))success failure:(void (^)(NSString*))failure
{
    
    [HMSNetWorkManager requestJsonDataWithPath:@"user/get-upload-token" withParams:nil withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            NSString *token = [[respondObj objectForKey:@"data"] objectForKey:@"token"];
            NSString *filename = [[respondObj objectForKey:@"data"] objectForKey:@"filename"];
            
            QNUploadManager *uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
            NSData*data =UIImageJPEGRepresentation(image,0.7);
            QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                                  
                                                    progressHandler:progress
                                  
                                                             params:nil
                                  
                                                           checkCrc:NO
                                  
                                                 cancellationSignal:nil];
            [uploadManager putData:data
                               key:filename
                             token:token
                          complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                              
                              if (info.statusCode == 200 && resp) {
                                  NSString *url= resp[@"key"];
                                  url = [HMSUtils escapedString:url];
                                  if (success) {
                                      
                                      success(url);
                                  }
                              }
                              else {
                                  if (failure) {
                                      
                                      failure(@"上传失败");
                                  }
                              }
                              
                          } option:opt];
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

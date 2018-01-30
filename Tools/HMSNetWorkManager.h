//
//  HMSNetWorkManager.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/29.
//  Copyright © 2017年 mirahome. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>
#import <Qiniu/QiniuSDK.h>
typedef enum{
    HttpRequestTypeGet = 0,
    HttpRequestTypePost
}HttpRequestType;

@interface HMSNetWorkManager : AFHTTPSessionManager

+ (HMSNetWorkManager *)shareManger;

+ (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(HttpRequestType)requestType
                       success:(void (^)(id respondObj))success failure:(void (^)(NSError *error))failure;

+ (void)requestJsonDataWithOutBaseUrlPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(HttpRequestType)requestType
                        success:(void (^)(id respondObj))success failure:(void (^)(NSError *error))failure;

//向七牛上传多张图片
+ (void)uploadImages:(NSArray*)imageArray progress:(void(^)(CGFloat))progress success:(void(^)(NSArray*))success failure:(void(^)(NSString*))failure;

//向七牛上传单张图片
+ (void)uploadImage:(UIImage *)image progress:(QNUpProgressHandler)progress success:(void (^)(NSString *url))success failure:(void (^)(NSString*))failure;
@end

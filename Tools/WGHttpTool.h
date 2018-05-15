//
//  WGHttpTool.h
//  UP优屏后台监控
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^HttpToolProgressBlock)(CGFloat progress);
typedef void (^HttpToolCompletionBlock)(NSError *error);

@interface WGHttpTool : NSObject
+ (instancetype)sharedManager;
/**
 *  通用方法GET
 *
 *  @param params 传入所需要的参数
 */
-(void)requestGET_WithParams:(id)params andBlock:(void (^)(id responseData, NSError *error))block;
/**
 *  通用方法
 *
 *  @param params 传入所需要的参数
 */
-(void)request_WithParams:(id)params andBlock:(void (^)(id responseData, NSError *error))block;


/* 通用get请求*/
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id respondObj))success failure:(void (^)(NSError *error))failure;

/*通用post请求 */
+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id respondObj ))success failure:(void(^)(NSError *error))failure;

/*通用put请求 */
+(void)put:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id respondObj ))success failure:(void(^)(NSError *error))failure;

/*
 *	@param image			图片对象
 *	@param url				上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name				与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度
 *	@param success		上传成功回调
 *	@param fail				上传失败回调
 *
 *	@return
 */
+ (void)uploadWithImage:(UIImage *)image url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters  progress:(void (^)(NSProgress * ))progress success:(void(^)(id respondObj))success failure:(void(^)(NSError *error))fail;

+(void)uploadWithData:(NSData *)data url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress * ))progress success:(void (^)(id))success failure:(void (^)(NSError *))fail;

-(void)uploadData:(NSData *)data url:(NSURL *)url progressBlock : (HttpToolProgressBlock)progressBlock completion:(HttpToolCompletionBlock) completionBlock;

/**
 下载数据
 */
-(void)downLoadFromURL:(NSURL *)url progressBlock : (HttpToolProgressBlock)progressBlock completion:(HttpToolCompletionBlock) completionBlock;

-(NSString *)fileSavePath:(NSString *)fileName;

+(void)UploadURl:(NSString *_Nonnull)url andParms:(NSMutableDictionary *_Nullable)parms andData:(NSData*_Nullable)data success:(void(^_Nullable)(NSDictionary* _Nullable  _Nullable result))success failure:(void(^_Nullable)(NSError * _Nonnull error))failure;

@end

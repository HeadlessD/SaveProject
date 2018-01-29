//
//  NDHttpTool.m
//  NextDoor
//
//  Created by 罗艺 on 2017/3/16.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import "NDHttpTool.h"
//#import "StringEncryption.h"
#import <AFNetworking/AFHTTPSessionManager.h>

//@"http://192.168.100.116/OrderService"////@"http://shopapp.letyy.com/Service/OrderService"////
#define APP_AMEI_KEY @"45#$aI3e@Ggk2017ACnro3*%^"

@implementation NDHttpTool

+(AFHTTPSessionManager*)getHttpM{
    static AFHTTPSessionManager*manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPSessionManager manager] ;
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        manager .requestSerializer.timeoutInterval=8;
    });
    return manager;
}

+(void)postWithURl:(NSString *)url andParms:(NSMutableDictionary *)parms success:(void(^)(NSDictionary*result))success failure:(void(^)(NSError * _Nonnull error))failure{
    AFHTTPSessionManager*manager=[self getHttpM];
    NSString* hideHub=parms[HIDEMBHUBKEY];
    if(!hideHub){
        //[MBHUDTool hideHUD];
    }
    

    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:parms success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //if (!hideHub) {
       // }
        NSDictionary*retDic=responseObject;
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"%@",error);
       
        failure(error);
    }];
}



+(void)UploadURl:(NSString *)url andParms:(NSMutableDictionary *)parms andData:(NSData*)data success:(void(^)(NSDictionary*result))success failure:(void(^)(NSError * _Nonnull error))failure{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager] ;
   manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager .requestSerializer.timeoutInterval=15;
    NSString* hideHub=parms[HIDEMBHUBKEY];
    if(!hideHub){
        //[MBHUDTool hideHUD];
       // [MBHUDTool showMessage:@""];
    }
    // 设置上传图片的名字
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        if ([[retDic allKeys] count]>0) {
//            //这里解密
//            NSString*  json=[StringEncryption DecryptString:[retDic valueForKey:[[retDic allKeys] objectAtIndex:0]] key:APP_AMEI_KEY];
//            // NSLog(@"str%@",json);
//            
//            NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
//            NSError *err;
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                options:NSJSONReadingMutableContainers
//                                                                  error:&err];
//            if(err)
//            {
//                NSLog(@"json解析失败：%@",err);
//                success(nil);
//            }else{
//                if ([NSObject responseSusOrNot:dic]) {
//                    
//                    success(dic);
//                }else{
//                    success(nil);
//                    [NSObject showResponseErrorMsg:dic];
//                }
//                
//            }
//        }
//        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"%@",error);
       
        failure(error);

    }];
}


+(void)getDataWithURl:(NSString *)url andParms:(NSMutableDictionary *)parms success:(void(^)(NSDictionary*result))success failure:(void(^)(NSError * _Nonnull error))failure{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager] ;
    // manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    if (parms) {
        //        NSArray *allkeys=[parms allKeys];
        //
        //        for (int i=0; i<allkeys.count; i++) {
        //
        //            NSString *key=[allkeys objectAtIndex:i];
        //
        //            id value=[parms objectForKey:key];
        //
        //            //加密
        //            NSString *aes=[StringEncryption EncryptString:value key:APP_AMEI_KEY];
        //
        //            [parms setValue:aes forKey:key];
        //        }
    }
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:parms success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*retDic=responseObject;
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"%@",error);
        
    }];
}



@end

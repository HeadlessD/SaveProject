//
//  NDHttpTool.h
//  NextDoor
//
//  Created by 罗艺 on 2017/3/16.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDHttpTool : NSObject
+(void)postWithURl:(NSString *_Nullable)url andParms:(NSDictionary *_Nullable)parms success:(void(^_Nonnull)(NSDictionary* _Nullable result))success failure:(void(^_Nullable)(NSError * _Nonnull error))failure;
+(void)getDataWithURl:(NSString *_Nullable)url andParms:(NSMutableDictionary *_Nullable)parms success:(void(^_Nonnull)(NSDictionary* _Nullable result))success failure:(void(^_Nullable)(NSError * _Nonnull error))failure;
+(void)UploadURl:(NSString *_Nonnull)url andParms:(NSMutableDictionary *_Nullable)parms andData:(NSData*_Nullable)data success:(void(^_Nullable)(NSDictionary*result))success failure:(void(^_Nullable)(NSError * _Nonnull error))failure;
@end

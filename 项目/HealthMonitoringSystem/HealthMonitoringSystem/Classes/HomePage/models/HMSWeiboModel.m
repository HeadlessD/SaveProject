//
//  HMSWeiboModel.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSWeiboModel.h"
#import <MJExtension.h>
@implementation HMSWeiboModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"comment":@"HMSWeiboCommentModel"};
}
@end

@implementation HMSWeiboCommentModel

-(instancetype)initWithComment_id:(NSString *)comment_id user_id:(NSString *)user_id user_name:(NSString *)user_name user_avatar:(NSString *)user_avatar time:(NSString *)time content:(NSString *)content is_delete:(BOOL )is_delete
{
    HMSWeiboCommentModel *commentM= [[HMSWeiboCommentModel alloc]init];
    commentM.comment_id =comment_id;
    commentM.user_id =user_id;
    commentM.user_name =user_name;
    commentM.user_avatar =user_avatar;
    commentM.time =time;
    commentM.content =content;
    commentM.is_delete = is_delete;
    return commentM;
}

@end

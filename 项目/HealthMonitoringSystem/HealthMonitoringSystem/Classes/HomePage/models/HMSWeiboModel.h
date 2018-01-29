//
//  HMSWeiboModel.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSWeiboModel : NSObject
//微博id
@property (nonatomic,strong) NSString *weibo_id;
//微博作者id
@property (nonatomic,strong) NSString *weibo_author_id;
//微博作者名称
@property (nonatomic,strong) NSString *weibo_author_name;
//微博作者头像
@property (nonatomic,strong) NSString *weibo_author_avatar;
//微博作者性别0男1女
@property (nonatomic,strong) NSString *weibo_author_sex;
//微博发表时间
@property (nonatomic,strong) NSString *weibo_created_time;
//微博内容
@property (nonatomic,strong) NSString *weibo_content;
//	位置
@property (nonatomic,strong) NSString *location;
//微博图片
@property (nonatomic,strong) NSArray *weibo_image;
//点赞数组
@property (nonatomic,strong) NSArray *praise;
//评论数组
@property (nonatomic,strong) NSArray *comment;
//true:可以删除,false:不可以删除
@property (nonatomic,assign) BOOL is_delete;
//true:已经点赞,false:未点赞
@property (nonatomic,assign) BOOL is_praise;
@end



@interface HMSWeiboCommentModel : NSObject
//评论id
@property (nonatomic,strong) NSString *comment_id;
//评论人id
@property (nonatomic,strong) NSString *user_id;
//评论人名称
@property (nonatomic,strong) NSString *user_name;
//评论人头像
@property (nonatomic,strong) NSString *user_avatar;
//评论的时间
@property (nonatomic,strong) NSString *time;
//父类评论人名称
@property (nonatomic,strong) NSString *parent_name;
//评论内容
@property (nonatomic,strong) NSString *content;
//true:可以删除,false:不可以删除
@property (nonatomic,assign) BOOL is_delete;

-(instancetype)initWithComment_id:(NSString *)comment_id user_id:(NSString *)user_id user_name:(NSString *)user_name user_avatar:(NSString *)user_avatar time:(NSString *)time content:(NSString *)content is_delete:(BOOL )is_delete;

@end

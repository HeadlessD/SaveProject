//
//  HMSArticleModel.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSArticleModel : NSObject
//作者
@property (nonatomic,strong) NSString *author;
//收藏数量
@property (nonatomic,strong) NSString *collect_count;
//正文链接
@property (nonatomic,strong) NSString *content;
//文章id
@property (nonatomic,strong) NSString *articleId;
//是否收藏
@property (nonatomic,assign) BOOL is_my_collect;
//缩略图
@property (nonatomic,strong) NSString *thumb;
//创建时间
@property (nonatomic,strong) NSString *time_created;
//更新时间
@property (nonatomic,strong) NSString *time_updated;
//文章标题
@property (nonatomic,strong) NSString *title;
//转换之后的时间
@property (nonatomic,strong) NSString *timeStr;
@end

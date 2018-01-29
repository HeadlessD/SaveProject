//
//  HMSWeiboCommetFrame.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/20.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSWeiboCommetFrame.h"
#import "HMSWeiboModel.h"

/**  话题头像宽高 */
CGFloat const HMSCommentAvatarWH = 30.0f ;
/**  Cell边距 */
CGFloat const HMSCommentCellMargin = 12.0f ;

@interface HMSWeiboCommetFrame ()
/** 头像frame */
@property (nonatomic , assign ) CGRect avatarFrame;
/** 昵称frame */
@property (nonatomic , assign ) CGRect nikeNameFrame;
/** 时间frame */
@property (nonatomic , assign ) CGRect createTimeFrame;
/** 评论内容frame */
@property (nonatomic , assign ) CGRect commentFrame;
/** 分割线frame */
@property (nonatomic , assign ) CGRect contentViewDeviderFrame;

/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign ) CGFloat cellHeight;

@end

@implementation HMSWeiboCommetFrame

-(void)setWeiboCommetnM:(HMSWeiboCommentModel *)weiboCommetnM
{
    _weiboCommetnM = weiboCommetnM;
    
    // 头像
    CGFloat avatarX = HMSCommentCellMargin;
    CGFloat avatarY = HMSCommentCellMargin;
    CGFloat avatarW = HMSCommentAvatarWH;
    CGFloat avatarH = HMSCommentAvatarWH;
    self.avatarFrame = (CGRect){{avatarX,avatarY},{avatarW,avatarH}};
    
    // 昵称
    CGFloat nikenameX = CGRectGetMaxX(self.avatarFrame) + HMSCommentCellMargin;
    CGFloat nikenameY = avatarY;
    CGFloat maxWidth = self.maxW - nikenameX - HMSCommentCellMargin;
    CGFloat nikenameW = [weiboCommetnM.user_name mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(maxWidth, 12)].width;
    CGFloat nikenameH = 12;
    self.nikeNameFrame = (CGRect){{nikenameX,nikenameY},{nikenameW,nikenameH}};
    
    // 发布时间
    CGFloat createTimeX = nikenameX;
    CGFloat createTimeY = CGRectGetMaxY(self.nikeNameFrame) + 8;
    CGFloat createTimeW = [weiboCommetnM.time mh_sizeWithFont:HMSFOND(11) limitSize:CGSizeMake(maxWidth, 11)].width;
    CGFloat createTimeH = 11;
    self.createTimeFrame = (CGRect){{createTimeX,createTimeY},{createTimeW,createTimeH}};
    
    // 文本内容
    CGFloat commentX = nikenameX;
    CGFloat commentY = CGRectGetMaxY(self.createTimeFrame) + 9;
    CGSize maxSize =[weiboCommetnM.content mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(maxWidth, MAXFLOAT)];
    CGFloat commentW = maxSize.width;
    CGFloat commentH = maxSize.height;
    self.commentFrame =(CGRect){{commentX,commentY},{commentW,commentH}};
    
    // 分割线
    CGFloat contentViewDeviderX = avatarX;
    CGFloat contentViewDeviderY = CGRectGetMaxY(self.commentFrame)+HMSCommentCellMargin-1;
    CGFloat contentViewDeviderW = self.maxW-24;
    CGFloat contentViewDeviderH = 1;
    self.contentViewDeviderFrame =(CGRect){{contentViewDeviderX,contentViewDeviderY},{contentViewDeviderW,contentViewDeviderH}};
    
    self.cellHeight = CGRectGetMaxY(self.commentFrame)+HMSCommentCellMargin;
}
@end

//
//  HMSWeiboFrame.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/19.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSWeiboFrame.h"
#import "HMSWeiboModel.h"
#import "HMSWeiboCommetFrame.h"
/**  话题头像宽高 */
CGFloat const HMSTopicAvatarWH = 40.0f ;
/**  Cell边距 */
CGFloat const HMSTopicCellMargin = 20.0f ;
/**  话题水平方向间隙 */
CGFloat const HMSTopicHorizontalSpace = 12.0f;
/**  话题垂直方向间隙 */
CGFloat const HMSTopicVerticalSpace = 12.0f ;
/**  图片直接的间隙 */
CGFloat const HMSTopicPicSpace = 10.0f ;

@interface HMSWeiboFrame ()
/** 白色背景frame */
@property (nonatomic , assign ) CGRect writeBGFrame;
/** 头像frame */
@property (nonatomic , assign ) CGRect avatarFrame;
/** 昵称frame */
@property (nonatomic , assign ) CGRect nikeNameFrame;
/** 时间frame */
@property (nonatomic , assign ) CGRect createTimeFrame;
/** 性别frame */
@property (nonatomic , assign ) CGRect sexFrame;
/** 删除按钮frame */
@property (nonatomic , assign ) CGRect deleteBtnFrame;
/** 话题内容frame */
@property (nonatomic , assign ) CGRect textFrame;
/** 图片集Viewframe */
@property (nonatomic , assign ) CGRect picViewFrame;
/** 地址frame */
@property (nonatomic , assign ) CGRect locationFrame;
/** 喜欢Viewframe */
@property (nonatomic , assign ) CGRect likeViewFrame;
/** 喜欢Labelframe */
@property (nonatomic , assign ) CGRect likeLabelFrame;
/** 评论Viewframe */
@property (nonatomic , assign ) CGRect commentViewFrame;
/** 评论Labelframe */
@property (nonatomic , assign ) CGRect commentLabelFrame;
/** 转发Btnframe */
@property (nonatomic , assign ) CGRect repeatBtnFrame;
/** 点赞人头像Viewframe */
@property (nonatomic , assign ) CGRect likeCollectionFrame;
/** 点赞人头像View左labelframe */
@property (nonatomic , assign ) CGRect likeCollectionLeftLabelFrame;
/** 点赞人头像View分割线frame */
@property (nonatomic , assign ) CGRect likeCollectionDividerFrame;
/** 评论详情Viewframe */
@property (nonatomic , assign ) CGRect commentTableViewFrame;
/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign ) CGFloat height;
@end
@implementation HMSWeiboFrame

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化
        _picFramesArray = [NSMutableArray array];
        
        _commentFrames = [NSMutableArray array];
    }
    return self;
}

-(void)setWeibo:(HMSWeiboModel *)weibo
{
    _weibo = weibo;
    
    // 头像
    CGFloat avatarX = HMSTopicCellMargin;
    CGFloat avatarY = HMSTopicCellMargin;
    CGFloat avatarW = HMSTopicAvatarWH;
    CGFloat avatarH = HMSTopicAvatarWH;
    self.avatarFrame = (CGRect){{avatarX,avatarY},{avatarW,avatarH}};
    
    // 昵称
    CGFloat nikenameX = CGRectGetMaxX(self.avatarFrame) + HMSTopicCellMargin;
    CGFloat nikenameY = avatarY;
    CGFloat maxWidth = KScreenWidth-24 -20 -50 -12-15-20;
    CGFloat nikenameW = [weibo.weibo_author_name mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(maxWidth, 15)].width;
    CGFloat nikenameH = 15;
    self.nikeNameFrame = (CGRect){{nikenameX,nikenameY},{nikenameW,nikenameH}};
    
     // 性别
    CGFloat sexX = CGRectGetMaxX(self.nikeNameFrame) + 10;
    CGFloat sexY = avatarY+1;
    CGFloat sexW = 13;
    CGFloat sexH = 13;
    self.sexFrame = (CGRect){{sexX,sexY},{sexW,sexH}};
    
    // 发布时间
    CGFloat createTimeX = nikenameX;
    CGFloat createTimeY = CGRectGetMaxY(self.nikeNameFrame) + HMSTopicHorizontalSpace;
    maxWidth = KScreenWidth -24 -20-createTimeX;
    CGFloat createTimeW = [weibo.weibo_created_time mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(maxWidth, 12)].width;
    CGFloat createTimeH = 12;
    self.createTimeFrame = (CGRect){{createTimeX,createTimeY},{createTimeW,createTimeH}};
    
    // 删除按钮
    CGFloat deleteBtnX = KScreenWidth -24 -20 -50;
    CGFloat deleteBtnY = HMSTopicCellMargin -7.5;
    CGFloat deleteBtnW = 50;
    CGFloat deleteBtnH = 30;
    self.deleteBtnFrame = (CGRect){{deleteBtnX,deleteBtnY},{deleteBtnW,deleteBtnH}};
    
    // 文本内容
    CGFloat textX = avatarX;
    CGFloat textY = CGRectGetMaxY(self.avatarFrame) + HMSTopicVerticalSpace;
    maxWidth = KScreenWidth -24 -40;
    CGSize maxSize =[weibo.weibo_content mh_sizeWithFont:HMSFOND(13) limitSize:CGSizeMake(maxWidth, MAXFLOAT)];
    CGFloat textW = maxSize.width;
    CGFloat textH = maxSize.height;
    self.textFrame =(CGRect){{textX,textY},{textW,textH}};
    
    CGFloat imageViewX =avatarX;
    CGFloat imageViewY = CGRectGetMaxY(self.textFrame) + HMSTopicVerticalSpace ;
    CGFloat imageViewW = KScreenWidth -24 -40;
    CGFloat imageViewH ;
    
    if (weibo.weibo_image.count==0) {
        imageViewY =CGRectGetMaxY(self.textFrame);
        imageViewH = 0;
        self.picViewFrame =(CGRect){{imageViewX,imageViewY},{imageViewW,imageViewH}};
    }else if(weibo.weibo_image.count==1){
        if (weibo.weibo_content.length==0) {
            imageViewY = CGRectGetMaxY(self.textFrame);
        }
        imageViewH = imageViewW /3*2;
        self.picViewFrame =(CGRect){{imageViewX,imageViewY},{imageViewW,imageViewH}};
        CGRect tempPicFrame = (CGRect){{0,0},{imageViewW,imageViewH}};
        [self.picFramesArray addObject:[NSValue valueWithCGRect:tempPicFrame]];
        
    }else if(weibo.weibo_image.count==2){
        
        CGFloat picWidth = (imageViewW - HMSTopicPicSpace)*0.5;
        imageViewH = picWidth;
        self.picViewFrame =(CGRect){{imageViewX,imageViewY},{imageViewW,imageViewH}};
        CGRect picFrameOne = (CGRect){{0,0},{picWidth,picWidth}};
        CGRect picFrameTwo = (CGRect){{picWidth+HMSTopicPicSpace,0},{picWidth,picWidth}};
        [self.picFramesArray addObjectsFromArray:@[[NSValue valueWithCGRect:picFrameOne],[NSValue valueWithCGRect:picFrameTwo]]];
    }else if(weibo.weibo_image.count==3||weibo.weibo_image.count==4){
        CGFloat picWidth = (imageViewW - HMSTopicPicSpace)*0.5;
        imageViewH = imageViewW;
        self.picViewFrame =(CGRect){{imageViewX,imageViewY},{imageViewW,imageViewH}};
        
        NSInteger count=weibo.weibo_image.count;
        int totalloc=2;
        for (int i=0; i<count; i++) {
            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGRect tempPicFrame =(CGRect){{(picWidth+HMSTopicPicSpace)*loc,(picWidth+HMSTopicPicSpace)*row},{picWidth,picWidth}};
            [self.picFramesArray addObject:[NSValue valueWithCGRect:tempPicFrame]];
        }
        
    }else
    {
        CGFloat picWidth = (imageViewW - HMSTopicPicSpace*2)/3;
        imageViewH = imageViewW;
        if (weibo.weibo_image.count<7) {
            imageViewH = picWidth * 2 + HMSTopicPicSpace;
        }
        self.picViewFrame =(CGRect){{imageViewX,imageViewY},{imageViewW,imageViewH}};
        
        NSInteger count=weibo.weibo_image.count;
        int totalloc=3;
        for (int i=0; i<count; i++) {
            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGRect tempPicFrame =(CGRect){{(picWidth+HMSTopicPicSpace)*loc,(picWidth+HMSTopicPicSpace)*row},{picWidth,picWidth}};
            [self.picFramesArray addObject:[NSValue valueWithCGRect:tempPicFrame]];
        }
    }
    
    // 位置
    CGFloat locationX = avatarX;
    CGFloat locationY = CGRectGetMaxY(self.picViewFrame);
    CGFloat locationW = 0;
    CGFloat locationH = 0;
    self.locationFrame = (CGRect){{locationX,locationY},{locationW,locationH}};
    if (weibo.location.length>0) {
        maxWidth = KScreenWidth -24 -40;
        NSString *locationStr = [[weibo.location componentsSeparatedByString:@"·"] componentsJoinedByString:@" "];
        CGSize locationMaxSize =[locationStr mh_sizeWithFont:HMSFOND(10) limitSize:CGSizeMake(maxWidth, 10)];
        self.locationFrame = (CGRect){{locationX,CGRectGetMaxY(self.picViewFrame)+12},locationMaxSize};
    }
    
    // 点赞按钮
    CGFloat likeBtnX = avatarX -7*0.5;
    CGFloat likeBtnY = CGRectGetMaxY(self.locationFrame) + HMSTopicHorizontalSpace -7*0.5;
    CGFloat likeBtnW = 25;
    CGFloat likeBtnH = 25;
    self.likeViewFrame = (CGRect){{likeBtnX,likeBtnY},{likeBtnW,likeBtnH}};
    
    // 点赞label
    CGFloat likeLabelX = CGRectGetMaxX(self.likeViewFrame)+2;
    CGFloat likeLabelY = likeBtnY;
    NSString *likeStr = [NSString stringWithFormat:@"%ld次",weibo.praise.count];
    CGFloat likeLabelW = [likeStr mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(150, 18)].width;
    CGFloat likeLabelH = likeBtnH;
    self.likeLabelFrame = (CGRect){{likeLabelX,likeLabelY},{likeLabelW,likeLabelH}};
    
    // 评论按钮
    CGFloat commentBtnX = CGRectGetMaxX(self.likeLabelFrame)+ HMSTopicCellMargin;
    CGFloat commentBtnY = likeBtnY;
    CGFloat commentBtnW = likeBtnW;
    CGFloat commentBtnH = likeBtnH;
    self.commentViewFrame = (CGRect){{commentBtnX,commentBtnY},{commentBtnW,commentBtnH}};
    
    // 评论label
    CGFloat commentLabelX = CGRectGetMaxX(self.commentViewFrame)+2;
    CGFloat commentLabelY = likeBtnY;
    NSString *commentStr = [NSString stringWithFormat:@"%ld条",weibo.comment.count];
    CGFloat commentLabelW = [commentStr mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(150, 18)].width;
    CGFloat commentLabelH = likeBtnH;
    self.commentLabelFrame = (CGRect){{commentLabelX,commentLabelY},{commentLabelW,commentLabelH}};
    
    // 转发按钮
    CGFloat repeatBtnX = KScreenWidth -24-20-18;
    CGFloat repeatBtnY = likeBtnY;
    CGFloat repeatBtnW = likeBtnW;
    CGFloat repeatBtnH = likeBtnH;
    self.repeatBtnFrame = (CGRect){{repeatBtnX,repeatBtnY},{repeatBtnW,repeatBtnH}};
    
    // cell背景
    CGFloat writeBGX = HMSTopicHorizontalSpace;
    CGFloat writeBGY = 6;
    CGFloat writeBGW = KScreenWidth-24;
    CGFloat writeBGH = CGRectGetMaxY(self.likeViewFrame)+ HMSTopicCellMargin-7*0.5;
    self.writeBGFrame = (CGRect){{writeBGX,writeBGY},{writeBGW,writeBGH}};
    
    //点赞头像左Label
    CGFloat likeCollectionLeftLabelW = [@"点了赞" mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(150, 12)].width;
    CGFloat likeCollectionLeftLabelX = KScreenWidth -24 -20 -likeCollectionLeftLabelW;
    CGFloat likeCollectionLeftLabelY = CGRectGetMaxY(self.likeViewFrame)+12-7*0.5+1;
    CGFloat likeCollectionLeftLabelH =0;
    self.likeCollectionLeftLabelFrame =(CGRect){{likeCollectionLeftLabelX,likeCollectionLeftLabelY},{likeCollectionLeftLabelW,likeCollectionLeftLabelH}};
    //点赞头像
    CGFloat likeCollectionViewX = avatarX;
    CGFloat likeCollectionViewY = CGRectGetMaxY(self.likeViewFrame)+12-7*0.5;
    CGFloat likeCollectionViewW = KScreenWidth -24 -40-likeCollectionLeftLabelW-5;
    CGFloat likeCollectionViewH =0;
    self.likeCollectionFrame = (CGRect){{likeCollectionViewX,likeCollectionViewY},{likeCollectionViewW,likeCollectionViewH}};
    
    //点赞头像分割线
    CGFloat likeCollectionDividerX = likeCollectionViewX;
    CGFloat likeCollectionDividerY = likeCollectionViewY;
    CGFloat likeCollectionDividerW = KScreenWidth -24 -40;
    CGFloat likeCollectionDividerH =0;
    self.likeCollectionDividerFrame =(CGRect){{likeCollectionDividerX,likeCollectionDividerY},{likeCollectionDividerW,likeCollectionDividerH}};
    if (weibo.praise.count>0) {
        
        likeCollectionViewH = 50;
        self.likeCollectionFrame = (CGRect){{likeCollectionViewX,likeCollectionViewY},{likeCollectionViewW,likeCollectionViewH}};
        
        self.writeBGFrame = (CGRect){{writeBGX,writeBGY},{writeBGW,CGRectGetMaxY(self.likeCollectionFrame)+ HMSTopicCellMargin}};
        
        likeCollectionLeftLabelH =likeCollectionViewH - 2;
        self.likeCollectionLeftLabelFrame =(CGRect){{likeCollectionLeftLabelX,likeCollectionLeftLabelY},{likeCollectionLeftLabelW,likeCollectionLeftLabelH}};
       
        likeCollectionDividerH =1;
        self.likeCollectionDividerFrame =(CGRect){{likeCollectionDividerX,likeCollectionDividerY},{likeCollectionDividerW,likeCollectionDividerH}};
        
    }
    
    //评论列表
    CGFloat comentTableViewX = avatarX;
    CGFloat comentTableViewY = CGRectGetMaxY(self.likeCollectionFrame);
    CGFloat comentTableViewW = KScreenWidth -24 -40;
    CGFloat comentTableViewH =0;
    self.commentTableViewFrame = (CGRect){{comentTableViewX,comentTableViewY},{comentTableViewW,comentTableViewH}};
    
  
    if (weibo.comment.count>0) {
        for (HMSWeiboCommentModel *commentM in weibo.comment) {
            HMSWeiboCommetFrame *commentFrame = [[HMSWeiboCommetFrame alloc] init];
            commentFrame.maxW = comentTableViewW;
            commentFrame.weiboCommetnM = commentM;
            [self.commentFrames addObject:commentFrame];
            
            comentTableViewH += commentFrame.cellHeight;
        }
        
        self.commentTableViewFrame = (CGRect){{comentTableViewX,comentTableViewY},{comentTableViewW,comentTableViewH}};
        
        self.writeBGFrame = (CGRect){{writeBGX,writeBGY},{writeBGW,CGRectGetMaxY(self.commentTableViewFrame)+ HMSTopicCellMargin}};
        
       
    }
    
    
    self.height = CGRectGetMaxY(self.writeBGFrame) + 6;
}

@end

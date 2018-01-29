//
//  HMSWeiboFrame.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/19.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSWeiboModel,HMSWeiboCommetFrame;
@interface HMSWeiboFrame : NSObject
/** 白色背景frame */
@property (nonatomic , assign , readonly) CGRect writeBGFrame;
/** 头像frame */
@property (nonatomic , assign , readonly) CGRect avatarFrame;
/** 昵称frame */
@property (nonatomic , assign , readonly) CGRect nikeNameFrame;
/** 时间frame */
@property (nonatomic , assign , readonly) CGRect createTimeFrame;
/** 性别frame */
@property (nonatomic , assign , readonly) CGRect sexFrame;
/** 删除按钮frame */
@property (nonatomic , assign , readonly) CGRect deleteBtnFrame;
/** 话题内容frame */
@property (nonatomic , assign , readonly) CGRect textFrame;
/** 图片集Viewframe */
@property (nonatomic , assign , readonly) CGRect picViewFrame;
/** 图片frame列表 */
@property (nonatomic , strong )  NSMutableArray *picFramesArray;
/** 地址frame */
@property (nonatomic , assign , readonly) CGRect locationFrame;
/** 喜欢Viewframe */
@property (nonatomic , assign , readonly) CGRect likeViewFrame;
/** 喜欢Labelframe */
@property (nonatomic , assign , readonly) CGRect likeLabelFrame;
/** 评论Viewframe */
@property (nonatomic , assign , readonly) CGRect commentViewFrame;
/** 评论Labelframe */
@property (nonatomic , assign , readonly) CGRect commentLabelFrame;
/** 转发Btnframe */
@property (nonatomic , assign , readonly) CGRect repeatBtnFrame;
/** 点赞人头像Viewframe */
@property (nonatomic , assign , readonly) CGRect likeCollectionFrame;
/** 点赞人头像View左labelframe */
@property (nonatomic , assign , readonly) CGRect likeCollectionLeftLabelFrame;
/** 点赞人头像View分割线frame */
@property (nonatomic , assign , readonly) CGRect likeCollectionDividerFrame;
/** 评论详情Viewframe */
@property (nonatomic , assign , readonly) CGRect commentTableViewFrame;

/** 评论尺寸模型 由于后期需要用到，所以不涉及为只读 */
@property (nonatomic , strong ) NSMutableArray <HMSWeiboCommetFrame*>*commentFrames;

/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign , readonly) CGFloat height;

/** 话题模型 */
@property (nonatomic , strong) HMSWeiboModel *weibo;
@end

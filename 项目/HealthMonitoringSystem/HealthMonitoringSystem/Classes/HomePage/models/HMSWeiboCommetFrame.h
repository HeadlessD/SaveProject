//
//  HMSWeiboCommetFrame.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/20.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSWeiboCommentModel;
@interface HMSWeiboCommetFrame : NSObject

/** 头像frame */
@property (nonatomic , assign , readonly) CGRect avatarFrame;
/** 昵称frame */
@property (nonatomic , assign , readonly) CGRect nikeNameFrame;
/** 时间frame */
@property (nonatomic , assign , readonly) CGRect createTimeFrame;
/** 评论内容frame */
@property (nonatomic , assign , readonly) CGRect commentFrame;
/** 分割线frame */
@property (nonatomic , assign , readonly) CGRect contentViewDeviderFrame;

/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign , readonly) CGFloat cellHeight;

/** 最大宽度 外界传递 */
@property (nonatomic , assign) CGFloat maxW;
/** 话题评论模型 */
@property (nonatomic , strong) HMSWeiboCommentModel *weiboCommetnM;
@end

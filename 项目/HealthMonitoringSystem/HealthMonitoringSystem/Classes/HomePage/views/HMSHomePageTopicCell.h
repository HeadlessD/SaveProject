//
//  HMSHomePageTopicCell.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/19.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMSWeiboFrame,HMSHomePageTopicCell,HMSWeiboCommentModel;
@protocol HMSHomePageTopicCellDelegate <NSObject>
@optional
/** 点击评论的事件回调 */
- (void)topicCellDidClickedComment:(HMSHomePageTopicCell *)topicCell;
/** 点击点赞的事件回调 */
- (void)topicCellDidClickedLike:(HMSHomePageTopicCell *)topicCell;
/** 点击点赞的事件回调 */
- (void)topicCellDidClickedDelete:(HMSHomePageTopicCell *)topicCell;
/** 点击点赞的事件回调 */
- (void)topicCellDidClickedRepeat:(HMSHomePageTopicCell *)topicCell;
/** 点击某一行的cell */
- (void)topicCell:(HMSHomePageTopicCell *)topicCell  deleteRowAtIndexPath:(NSIndexPath *)indexPath commentM:(HMSWeiboCommentModel *)comment;
@optional

@end
@interface HMSHomePageTopicCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 话题模型数据源 */
@property (nonatomic , strong) HMSWeiboFrame *weiboFrame;
/** 代理 */
@property (nonatomic , weak) id <HMSHomePageTopicCellDelegate> delegate;
@end

//
//  HMSHomePageCommentCell.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/20.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSHomePageCommentCell,HMSWeiboCommetFrame,HMSWeiboCommentModel;
@protocol HMSHomePageCommentCellDelegate <NSObject>

@optional
/** 点击评论cell的昵称 */
- (void) weiboCommentCell:(HMSHomePageCommentCell *)weiboCommentCell deleteComment:(HMSWeiboCommentModel *)comment;

@end

@interface HMSHomePageCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 评论Frame */
@property (nonatomic , strong) HMSWeiboCommetFrame *commentFrame;

@property (nonatomic,strong) UIView *contentViewDevider;

/** 代理 */
@property (nonatomic , weak) id <HMSHomePageCommentCellDelegate> delegate;
@end

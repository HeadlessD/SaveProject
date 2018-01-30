//
//  HMSHomePageOldManCollectionCell.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMSOldManModel,HMSHomePageOldManCollectionCell;

@protocol HMSHomePageOldManCollectionCellDelegate <NSObject>

@optional
/** 点击邀请按钮 */
- (void)oldManCardCellDidClickInviteBtn:(HMSHomePageOldManCollectionCell *)oldManCardCell addFriend:(HMSOldManModel *)oldMan;

/** 点击头像 */
- (void)oldManCardCellDidClickHeaderImg:(HMSHomePageOldManCollectionCell *)oldManCardCell addFriend:(HMSOldManModel *)oldMan;
@end

@interface HMSHomePageOldManCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UIButton *oldManCardBtn;

@property (nonatomic,strong) HMSOldManModel *oldManM;



/** 代理 */
@property (nonatomic , weak) id <HMSHomePageOldManCollectionCellDelegate> delegate;
@end

//
//  HMSOldManFriendShipCell.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSOldManFriendModel;
@interface HMSOldManFriendShipCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *friendHeaderImagView;

@property (weak, nonatomic) IBOutlet UILabel *nikeNameTitle;

@property (nonatomic,strong)HMSOldManFriendModel *friendModel;
@end

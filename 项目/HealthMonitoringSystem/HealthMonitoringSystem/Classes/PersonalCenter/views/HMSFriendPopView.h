//
//  HMSFriendPopView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMSFriendPopViewAction)(NSString *);
@class HMSOldManFriendModel;
@interface HMSFriendPopView : UIView
-(instancetype)initWithFrame:(CGRect)frame friendModel:(HMSOldManFriendModel *)friendModel;

-(void)show;

@property (nonatomic,copy) HMSFriendPopViewAction deleteFriend;
@end

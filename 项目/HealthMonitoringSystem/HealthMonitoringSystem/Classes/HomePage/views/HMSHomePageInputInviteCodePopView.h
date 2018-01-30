//
//  HMSHomePageInputInviteCodePopView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/24.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMSHomePageInputInviteCodePopViewAction)(NSString *);

@interface HMSHomePageInputInviteCodePopView : UIView
-(void)show;

@property (nonatomic,copy)HMSHomePageInputInviteCodePopViewAction popViewAciton;
@end

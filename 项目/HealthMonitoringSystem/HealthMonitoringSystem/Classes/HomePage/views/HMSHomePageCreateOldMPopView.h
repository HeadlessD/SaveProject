//
//  HMSHomePageCreateOldMPopView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/24.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMSHomePageCreateOldMPopViewAction)(NSString *);
@interface HMSHomePageCreateOldMPopView : UIView
-(void)show;

@property (nonatomic,copy) HMSHomePageCreateOldMPopViewAction popViewAction;
@end

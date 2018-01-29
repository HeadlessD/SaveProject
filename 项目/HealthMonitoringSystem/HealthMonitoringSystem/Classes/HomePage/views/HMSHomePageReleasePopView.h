//
//  HMSHomePageReleasePopView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/17.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HMSHomePageReleasePopViewAction)(NSInteger);

@interface HMSHomePageReleasePopView : UIView
-(void)show;

@property (nonatomic,copy)HMSHomePageReleasePopViewAction popViewSelectAction;


@end

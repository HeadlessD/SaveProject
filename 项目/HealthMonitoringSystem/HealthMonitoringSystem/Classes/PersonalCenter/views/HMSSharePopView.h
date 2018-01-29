//
//  HMSSharePopView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/13.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMSSharePopViewAction)(NSInteger);
@interface HMSSharePopView : UIView
-(void)show;

@property (nonatomic,copy) HMSSharePopViewAction popViewSelectAction;
@end

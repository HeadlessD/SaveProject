//
//  HMSOldManCardPopView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/21.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMSOldManCardPopViewAction)(NSString *);
@class HMSOldManModel;
@interface HMSOldManCardPopView : UIView
-(instancetype)initWithFrame:(CGRect)frame oldManModel:(HMSOldManModel *)oldMan;
-(void)show;

@property (nonatomic,copy) HMSOldManCardPopViewAction inviteBtnClick;
@end

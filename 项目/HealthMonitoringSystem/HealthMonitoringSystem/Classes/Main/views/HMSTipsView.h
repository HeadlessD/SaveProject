//
//  HMSTipsView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSTipsView : UIView
- (instancetype) initWithTitle:(NSString *)title
                          icon:(UIImage *)icon;

- (void)showInView:(UIView*)view;
@end

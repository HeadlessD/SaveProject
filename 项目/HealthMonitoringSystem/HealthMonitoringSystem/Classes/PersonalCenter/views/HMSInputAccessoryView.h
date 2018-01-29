//
//  HMSInputAccessoryView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/5.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HMSInputAccessoryBlock)();

@interface HMSInputAccessoryView : UIView
- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text Block:(HMSInputAccessoryBlock)block;
@end

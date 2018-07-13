//
//  UIViewController+HCPopTap.h
//  EquipmentDog
//
//  Created by chuang Hao on 2017/11/28.
//  Copyright © 2017年 pusikeji. All rights reserved.
//
// 侧滑返回手势区域，和是否禁止返回按钮点击

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回YES允许pop，NO 则不 pop
- (BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (HCPopTap)<BackButtonHandlerProtocol>

@end

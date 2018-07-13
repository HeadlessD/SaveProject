//
//  HMSBaseVC.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/30.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSBaseVC : UIViewController

// 带图片的返回按钮
- (void)setBackNavItem:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize;
// 带图片的左按钮
- (void)setLeftNavItem:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize;
// 带图片的右按钮
- (void)setRightNavItem:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize;

// 生成一个带文字的导航栏左按钮
- (void)setNavLeftItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor  size:(CGSize)size;
// 生成一个带文字的导航栏右按钮
- (void)setNavRightItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor size:(CGSize)size;
- (UIButton *)setNavRightItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor fontSize:(float)fontSize size:(CGSize)size;

- (void)didPressLeftItem:(UIButton *)btn;
- (void)didPressRightItem:(UIButton *)btn;
- (void)didPressBackItem:(UIButton *)btn;

@end

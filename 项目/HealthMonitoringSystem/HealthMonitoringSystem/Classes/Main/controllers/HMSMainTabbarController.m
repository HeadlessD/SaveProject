//
//  HMSMainTabbarController.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMainTabbarController.h"
#import "HMSCustomNavigationVC.h"
#import "HMSHMSArticleVC.h"
#import "HMSHMSPersonalCenterVC.h"
#import "HMSHomePageVC.h"
#import "HMSMonitorVC.h"

@interface HMSMainTabbarController ()

@end

@implementation HMSMainTabbarController

+(void)initialize
{
    
    UITabBarItem *item =[UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:HMSThemeColor} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:HMSThemeColor} forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    //    UITabBar *tabbar =[UITabBar appearance];
    //    tabbar.backgroundColor =[UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    [self setUpVC];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    //为tabbar添加阴影
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [self dropShadowWithOffset:CGSizeMake(0, -0.5)
                        radius:1
                         color:[UIColor grayColor]
                       opacity:0.3];
    
    
    
    // Do any additional setup after loading the view.
}
//为tabbar添加阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}
-(void)setUpVC
{
    HMSHomePageVC *vc1 =[[HMSHomePageVC alloc]init];
    [self setUpVC:vc1 WithIcon:@"tabbar_homepage" SelectedIcon:@"tabbar_homepage_select" title:@"我的"];
    
    HMSMonitorVC *vc2 =[[HMSMonitorVC alloc]init];
    [self setUpVC:vc2 WithIcon:@"tabbar_monitor" SelectedIcon:@"tabbar_monitor_select" title:@"监测"];
    
    HMSHMSArticleVC *vc3 =[[HMSHMSArticleVC alloc]init];
    [self setUpVC:vc3 WithIcon:@"tabbar_article" SelectedIcon:@"tabbar_article_select" title: @"文章"];
    
    UIViewController *vc4 =[[UIViewController alloc]init];
    [self setUpVC:vc4 WithIcon:@"tabbar_store" SelectedIcon:@"tabbar_store_select" title:@"商城"];
    
    HMSHMSPersonalCenterVC *vc5 =[[HMSHMSPersonalCenterVC alloc]init];
    [self setUpVC:vc5 WithIcon:@"tabbar_personalCenter" SelectedIcon:@"tabbar_personalCenter_select" title:@"个人中心"];
}

-(void)setUpVC:(UIViewController *)VC WithIcon:(NSString *)icon SelectedIcon:(NSString *)selectedIcon title:(NSString *)title
{
    VC.tabBarItem.image =[[UIImage imageNamed:icon]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage =[[UIImage imageNamed:selectedIcon]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    VC.title =title;
    [VC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
//    [VC.tabBarItem setImageInsets:UIEdgeInsetsMake(-10, 0, 10, 0)];
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HMSThemeColor} forState:UIControlStateNormal];
    HMSCustomNavigationVC *nvc =[[HMSCustomNavigationVC alloc]initWithRootViewController:VC];
    
    [self addChildViewController:nvc];
}
@end

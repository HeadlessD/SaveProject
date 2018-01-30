//
//  XMGTabBarController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGNavigationController.h"
#import "ATRealTimeVc.h"
#import "ATApplicationVc.h"

@interface XMGTabBarController()

@end

@implementation XMGTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = UIColorFromHex(0x666666);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
   // selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
    //[self setupChildVc:[[HomeVc alloc] init] title:@"首页" image:@"首页-正常" selectedImage:@"首页-按下"];
    
   /* NdShopCatVc*catVc=[[NdShopCatVc alloc] init];
    catVc.isHaveTabBar=YES;
    [self setupChildVc:catVc title:@"商品分类" image:@"分类-正常" selectedImage:@"分类-按下"];
    */
    //实时 应用 消息 我的
    [self setupChildVc:[[ATRealTimeVc alloc]init] title:@"实时" image:@"tab_shishi_weixuanzhong" selectedImage:@"tab_shishi_xuanzhong"];
    [self setupChildVc:[[ATApplicationVc alloc]init] title:@"应用" image:@"tab_yingyong_weixuanzhong" selectedImage:@"tab_yingyong_xuanzhong"];
    [self setupChildVc:[[UIViewController alloc]init] title:@"消息" image:@"tab_xiaoxi_weixuanzhong" selectedImage:@"tab_xiaoxi_xuanzhong"];
    [self setupChildVc:[[UIViewController alloc]init] title:@"我的" image:@"tab_xiaoxi_weixuanzhong" selectedImage:@"tab_xiaoxi_xuanzhong"];
    
    // 更换tabBar
   // [self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];
    
   }

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    UIImage*img=[UIImage imageNamed:image];
    vc.tabBarItem.image=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage*sImg=[UIImage imageNamed:selectedImage];
    vc.tabBarItem.selectedImage = [sImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

-(void)addLocationVc{
//    NdLocationVc*locVc=[[NdLocationVc alloc]init];
//XMGNavigationController *nav =(XMGNavigationController*) self.childViewControllers[self.selectedIndex];
//    [nav pushViewController:locVc animated:YES];
}


@end

//
//  HMSCustomNavigationVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/29.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSCustomNavigationVC.h"

@interface HMSCustomNavigationVC ()<UINavigationControllerDelegate>

@end

@implementation HMSCustomNavigationVC
-(instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}
+ (void)initialize{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    //    [[UINavigationBar appearance] setBackgroundColor:UPThemeColor];
    [UINavigationBar appearance].titleTextAttributes=@{NSFontAttributeName:iPhone5_5s?HMSFOND(18):HMSFOND(19),NSForegroundColorAttributeName:UIColorFromRGB(0x1976d2)};
    
    
    // 设置item
    //    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //    // UIControlStateNormal
    //    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    //    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    //    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    //    // UIControlStateDisabled
    //    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    //    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate =(id)self;
    self.interactivePopGestureRecognizer.enabled = YES;
//    [self navigationBar].layer.shadowColor = [UIColor grayColor].CGColor; //shadowColor阴影颜色
//    [self navigationBar].layer.shadowOffset = CGSizeMake(0 , 0.5f); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
//    [self navigationBar].layer.shadowOpacity = 0.3f;//阴影透明度，默认0
//    [self navigationBar].layer.shadowRadius = 1.0f;//阴影半径
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}


//push的时候,是否保留下方的tabBar判断方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count>0) {
        
        
        UIButton *back =[[UIButton alloc]init];
        //[back setTitle:@"返回" forState:UIControlStateNormal];
        back.titleLabel.font = iPhone5_5s?HMSFOND(15):HMSFOND(17);
        [back setImage:[[UIImage imageNamed:@"navigationBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        //        [back setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        back.imageView.contentMode =UIViewContentModeScaleAspectFill;
        [back setTitleColor:UIColorFromRGB(0x1976d2) forState:UIControlStateNormal];
        //[back setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        back.size =CGSizeMake(50, 40);
        //        back.titleEdgeInsets =UIEdgeInsetsMake(0, 5, 0, 0);
        //        back.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        back.contentEdgeInsets =UIEdgeInsetsMake(0, -25, 0, 0);
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:back];
        viewController.hidesBottomBarWhenPushed =YES ;
        
    }
    
    
    [super pushViewController:viewController animated:YES];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}



-(UIViewController *)childViewControllerForStatusBarHidden
{
    return self.topViewController;
}
/**不要调用我自己(就是UINavigationController)的preferredStatusBarStyle方法，而是去调用navigationController.topViewController的preferredStatusBarStyle方*/
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}



@end

//
//  POSTNavigationController.m
//  Post
//
//  Created by Haochuang on 16/4/16.
//  Copyright © 2016年 BML. All rights reserved.
//

#import "POSTNavigationController.h"

@interface POSTNavigationController ()

@end

@implementation POSTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //返回按钮图片
    UIImage *backImage = [Global imageWithIcon:Navbar_back_icon inFont:@"iconfont" width:22 height:22 color:[UIColor whiteColor]];
   
    if (@available(iOS 11.0, *)) {
        UIImage *backButtonImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationBar.backIndicatorImage = backButtonImage;
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    }
    else {
        UIImage *backButtonImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    //设置导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:UNIN_NAVIBAR_COLOR];
    [UINavigationBar appearance].translucent = NO;
    
    //设置导航栏字体大小和颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont appFontSize:18 fontName:PINGFANG_REGULAR],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //隐藏导航栏自带边框
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navBarHairlineImageView.hidden = YES;
}

//找到nav边框黑线(findHairlineImageViewUnder)
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    //解决iPhone X push跳转时tabbar上移问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end

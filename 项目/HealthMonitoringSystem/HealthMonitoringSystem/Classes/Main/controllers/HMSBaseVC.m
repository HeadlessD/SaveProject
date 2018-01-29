//
//  HMSBaseVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/30.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSBaseVC.h"

@interface HMSBaseVC ()

@end

@implementation HMSBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

// 带图片的返回按钮
- (void)setBackNavItem:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize
{
    self.navigationItem.leftBarButtonItem = [self setNavItem:normalBgImg hightLBgImg:highLBgImg imageSize:imageSize action:@selector(didPressBackItem:)];
}
// 带图片的左按钮
- (void)setLeftNavItem:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize
{
    self.navigationItem.leftBarButtonItem = [self setNavItem:normalBgImg hightLBgImg:highLBgImg imageSize:imageSize action:@selector(didPressLeftItem:)];
}
// 带图片的右按钮
- (void)setRightNavItem:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize
{
    self.navigationItem.rightBarButtonItem  = [self setNavItem:normalBgImg hightLBgImg:highLBgImg imageSize:imageSize action:@selector(didPressRightItem:)];
}

// 生成一个带文字的导航栏左按钮
- (void)setNavLeftItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor  size:(CGSize)size
{
    [self setNavLeftItem:normalTitle normalColor:normalColor highLTColor:highLTColor fontSize:14 size:size];
}
- (void)setNavLeftItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor fontSize:(float)fontSize size:(CGSize)size
{
    self.navigationItem.leftBarButtonItem = [[self setNavItem:normalTitle hightLTitle:nil normalColor:normalColor highLTColor:highLTColor fontSize:fontSize size:size action:@selector(didPressLeftItem:)] firstObject];
}
// 生成一个带文字的导航栏右按钮
- (void)setNavRightItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor size:(CGSize)size
{
    [self setNavRightItem:normalTitle normalColor:normalColor highLTColor:highLTColor fontSize:15 size:size];
}
- (UIButton *)setNavRightItem:(NSString *)normalTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor fontSize:(float)fontSize size:(CGSize)size
{
    NSArray *array =[self setNavItem:normalTitle hightLTitle:nil normalColor:normalColor highLTColor:highLTColor fontSize:fontSize size:size action:@selector(didPressRightItem:)];
    self.navigationItem.rightBarButtonItem  = [array firstObject];
    return [array lastObject];
}

#pragma mark - 生成UIBarButtonItem的基本方法

// 带图片的导航栏按钮 -- 基本方法
- (UIBarButtonItem *)setNavItem:(NSString *)normalBgImg hightLBgImg:(NSString *)highLBgImg imageSize:(CGSize)imageSize action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSizeEqualToSize(imageSize, CGSizeZero) ? (btn.frame = CGRectMake(0, 0, KNavItemSize.width, KNavItemSize.height)) : (btn.frame = CGRectMake(0, 0, imageSize.width, imageSize.height));
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self setBtn:btn normalBgImg:normalBgImg highLBgImg:highLBgImg];
    return  [[UIBarButtonItem alloc]initWithCustomView:btn];
}
//带文字的导航栏按钮--基本方法
- (NSArray *)setNavItem:(NSString *)normalTitle hightLTitle:(NSString *)hightLTitle normalColor:(UIColor *)normalColor highLTColor:(UIColor *)highLTColor fontSize:(float)fontSize size:(CGSize)size action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setBtn:btn normalTitle:normalTitle highLTitle:hightLTitle];
    [self setBtn:btn normalTitleColor:normalColor highLTitleColor:highLTColor];
    [self setBtn:btn fontSize:fontSize];
    CGFloat btnWidth = [NSString widthWithString:normalTitle andStrFont:HMSFOND(16) andMaxSize:CGSizeMake(80, 25)];
    CGSizeEqualToSize(size, CGSizeZero) ? (btn.frame = CGRectMake(0, 0, btnWidth, 25)) : (btn.frame = CGRectMake(0, 0, size.width, size.height));
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return  @[[[UIBarButtonItem alloc]initWithCustomView:btn],btn];
}

#pragma mark - 设置button的基本属性方法

// 设定button的标题；
- (void)setBtn:(UIButton *)btn normalTitle:(NSString *)normalTitle highLTitle:(NSString *)highLTitle
{
    NSAssert(btn != nil, @"UIButton 不能为空");
    
    if (normalTitle) {
        [btn setTitle:normalTitle forState:UIControlStateNormal];
    }
    if (highLTitle) {
        [btn setTitle:highLTitle forState:UIControlStateHighlighted];
    }else{
        [btn setTitle:normalTitle forState:UIControlStateHighlighted];
    }
}
// 设定button的标题的颜色；
- (void)setBtn:(UIButton *)btn normalTitleColor:(UIColor *)normalColor highLTitleColor:(UIColor *)highColor
{
    NSAssert(btn != nil, @"UIButton 不能为空");
    
    if (normalColor) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }else{
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (highColor) {
        [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    }
}

// 设定button的背景图片；
- (void)setBtn:(UIButton *)btn normalBgImg:(NSString *)normalBgImg highLBgImg:(NSString *)highLBgImg
{
    NSAssert(btn != nil, @"UIButton 不能为空");
    
    if (normalBgImg) {
        [btn setBackgroundImage:[UIImage imageNamed:normalBgImg] forState:UIControlStateNormal];
    }
    if (highLBgImg) {
        [btn setBackgroundImage:[UIImage imageNamed:highLBgImg] forState:UIControlStateHighlighted];
    }
}

//设定button的字体大小；
- (void)setBtn:(UIButton *)btn fontSize:(float)fontSize
{
    NSAssert(btn != nil, @"UIButton 不能为空");
    if (fontSize) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    }else{
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
}

#pragma mark - 处理点击事件的动作
- (void)didPressLeftItem:(UIButton *)btn
{
}
- (void)didPressRightItem:(UIButton *)btn
{
    
}
- (void)didPressBackItem:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
    // [[MachtalkSDK Instance] removeSdkDelegate:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

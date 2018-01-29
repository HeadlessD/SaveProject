//
//  HMSAccountInfoVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/11.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSAccountInfoVC.h"
#import "HMSChangePWWithOldPWVC.h"
@interface HMSAccountInfoVC ()

@property (nonatomic,strong)UIButton *phoneNum;

@property (nonatomic,strong)UIButton *loginPassWord;

@end

@implementation HMSAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号信息";
    self.view.backgroundColor = HMSThemeBackgroundColor;
    
    [self initView];
}


-(void)initView
{
    UIView *listViewOne =[[UIView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth -24, 100)];
    listViewOne.backgroundColor =[UIColor whiteColor];
    listViewOne.layer.cornerRadius = 3;
    [self.view addSubview:listViewOne];
    
    NSString *phoneNumText = [HMSAccount shareAccount].mobile;
    NSArray *phoneNumArray = @[[phoneNumText substringToIndex:3],[phoneNumText substringWithRange:NSMakeRange(3, 4)],[phoneNumText substringFromIndex:7]];
    phoneNumText = [phoneNumArray componentsJoinedByString:@"-"];
    self.phoneNum = [self buttonWithTitle:@"电话号码" text:phoneNumText contentText:nil rect:CGRectMake(0, 0, listViewOne.width, 50) isLine:YES clickAction:nil viewController:self];
    [listViewOne addSubview:self.phoneNum];
    
    self.loginPassWord = [self buttonWithTitle:@"登录密码" text:nil contentText:@"已设置" rect:CGRectMake(0, 50, listViewOne.width, 50) isLine:NO clickAction:@selector(loginPassWordClick:) viewController:self];
   
    [listViewOne addSubview:self.loginPassWord];
    
    
}


-(void)loginPassWordClick:(UIButton *)btn
{
    HMSChangePWWithOldPWVC *changePWVVC = [[HMSChangePWWithOldPWVC alloc]init];
    [self.navigationController pushViewController:changePWVVC animated:YES];
}

#pragma mark ---生产定制按钮工厂方法
-(UIButton *)buttonWithTitle:(NSString *)title text:(NSString *)text contentText:(NSString *)contentTxet rect:(CGRect )rect isLine:(BOOL)isline clickAction:(SEL)clickAction viewController:(id)viewController
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =rect;
    
    
    
    
    UILabel *titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 20)];
    titleLabel.font =HMSFOND(16);
    titleLabel.textAlignment =NSTextAlignmentLeft;
    titleLabel.textColor =[UIColor blackColor];
    titleLabel.centerY =btn.height*0.5;
    titleLabel.text =title;
    titleLabel.size = [title boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(16)} context:0].size;
    [btn addSubview:titleLabel];
    
    
    [btn addTarget:viewController action:clickAction forControlEvents:UIControlEventTouchUpInside];
    
    
    if (text) {
        UILabel *textLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 20)];
        textLabel.font =HMSFOND(15);
        textLabel.textAlignment =NSTextAlignmentRight;
        textLabel.textColor =HMSThemeColor;
        textLabel.centerY =btn.height*0.5;
        textLabel.text =text;
        textLabel.size = [text boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(15)} context:0].size;
        textLabel.x = btn.width -textLabel.width-20;
        [btn addSubview:textLabel];
    }
    if (contentTxet) {
        
        UIImageView *arraw =[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-7-20, 0, 7, 15)];
        arraw.image =[UIImage imageNamed:@"personalCenter_garyArrow"];
        arraw.centerY =btn.height *0.5;
        [btn addSubview:arraw];
        
        UILabel *textLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 20)];
        textLabel.font =HMSFOND(15);
        textLabel.textAlignment =NSTextAlignmentRight;
        textLabel.textColor =[UIColor lightGrayColor];
        textLabel.centerY =btn.height*0.5;
        textLabel.text =contentTxet;
        textLabel.size = [contentTxet boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(15)} context:0].size;
        textLabel.x = CGRectGetMinX(arraw.frame) -textLabel.width-5;
        [btn addSubview:textLabel];
    }
    
  
    if(isline){
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, btn.height-1, btn.width, 1)];
        line.backgroundColor =HMSThemeBackgroundColor;
        line.alpha =1;
        [btn addSubview:line];
        
    }
    
    if ([title isEqualToString:@"电话号码"]) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(3,3)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
    }else if([title isEqualToString:@"登录密码"])
    {
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:HMSCustomColor(190, 190, 190)] forState:UIControlStateHighlighted];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
    }
    
    
    return  btn;
}

@end

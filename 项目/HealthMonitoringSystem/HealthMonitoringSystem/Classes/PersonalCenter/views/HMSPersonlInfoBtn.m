//
//  HMSPersonlInfoBtn.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/5.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSPersonlInfoBtn.h"

@implementation HMSPersonlInfoBtn

+(HMSPersonlInfoBtn *)buttonWithTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image rect:(CGRect )rect icon:(NSString *)icon cornerType:(HMSPersonlInfoBtnCornerType)cornerType isLine:(BOOL)isline clickAction:(SEL)clickAction viewController:(id)viewController
{
    HMSPersonlInfoBtn *btn =[HMSPersonlInfoBtn buttonWithType:UIButtonTypeCustom];
    btn.frame =rect;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:HMSCustomColor(190, 190, 190)] forState:UIControlStateHighlighted];
    [btn addTarget:viewController action:clickAction forControlEvents:UIControlEventTouchUpInside];
    
    
    btn.mainTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 20)];
    btn.mainTitleLabel.font =HMSFOND(17);
    btn.mainTitleLabel.textAlignment =NSTextAlignmentLeft;
    btn.mainTitleLabel.textColor =[UIColor blackColor];
    btn.mainTitleLabel.centerY =btn.height*0.5;
    btn.mainTitleLabel.text =title;
    btn.mainTitleLabel.size = [title boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(17)} context:0].size;
    [btn addSubview:btn.mainTitleLabel];
    

    if (icon) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-65-15, 0, 65, 25)];
        imageView.image =[UIImage imageNamed:icon];
        imageView.centerY =btn.height *0.5;
        [btn addSubview:imageView];
    }
    
    btn.textTitleTF = [UITextField textFieldWithPlaceholder:nil Font:HMSFOND(15) TextColor:HMSThemeColor HorderColor:
                       nil BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    btn.textTitleTF.frame = CGRectMake(CGRectGetMaxX(btn.mainTitleLabel.frame)+20, 0, btn.width-40-CGRectGetMaxX(btn.mainTitleLabel.frame), 40);
    btn.textTitleTF.text = text;
    btn.textTitleTF.centerY =btn.height*0.5;
    btn.textTitleTF.hidden = YES;
    [btn addSubview:btn.textTitleTF];
    
    btn.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.mainTitleLabel.frame)+20, 0, 20, 20)];
    btn.iconImageView.centerY =btn.height*0.5;
    btn.iconImageView.image =image;
    btn.iconImageView.hidden = YES;
    [btn addSubview:btn.iconImageView];
    
    if(isline){
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, btn.height-1, btn.width, 1)];
        line.backgroundColor =HMSThemeBackgroundColor;
        line.alpha =1;
        [btn addSubview:line];
        
        
    }
    
    if (cornerType == HMSPersonlInfoBtnCornerTop) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(3,3)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
    }else if(cornerType == HMSPersonlInfoBtnCornerBottom)
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
    }

  
    return  btn;
}

@end

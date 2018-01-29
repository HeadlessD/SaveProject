//
//  HMSOldManPropertyCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSOldManPropertyCell.h"

@interface HMSOldManPropertyCell ()
@property (nonatomic,strong) UILabel *mainTitleLabel;



//@property (nonatomic,strong) UIImageView *iconImageView;
@end

@implementation HMSOldManPropertyCell

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title text:(NSString *)text Placeholder:(NSString *)placeholder rightImg:(UIImage *)rightImg cornerType:(HMSOldManPropertyCellCornerType)cornerType isLine:(BOOL)isline
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.mainTitleLabel =[UILabel labelWithRect:CGRectMake(20, 0, 100, 20) text:title textColor:[UIColor blackColor] fontSize:16 textAlignment:NSTextAlignmentLeft];
        self.mainTitleLabel.centerY =self.height*0.5;
        self.mainTitleLabel.size = [title boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(16)} context:0].size;
        [self addSubview:self.mainTitleLabel];
        
        
        self.textTitleTF = [UITextField textFieldWithPlaceholder:placeholder Font:HMSFOND(15) TextColor:HMSThemeColor HorderColor:
                           [UIColor lightGrayColor] BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
        self.textTitleTF.frame = CGRectMake(100, 0, self.width-100-40, 40);
//        self.textTitleTF.text = text;
        self.textTitleTF.centerY =self.height*0.5;
        [self addSubview:self.textTitleTF];
        
        
        if (rightImg) {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.width-15-20, 0, 15, 15)];
            imageView.image =rightImg;
            imageView.centerY =self.height *0.5;
            [self addSubview:imageView];
        }
        
        
        if(isline){
            UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
            line.backgroundColor =HMSThemeBackgroundColor;
            line.alpha =1;
            [self addSubview:line];
        }
        
        if (cornerType == HMSOldManPropertyCellCornerTop) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(3,3)];//圆角大小
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            self.layer.mask = maskLayer;
        }else if(cornerType == HMSOldManPropertyCellCornerBottom)
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            self.layer.mask = maskLayer;
        }
        
    }
    return self;
}



@end

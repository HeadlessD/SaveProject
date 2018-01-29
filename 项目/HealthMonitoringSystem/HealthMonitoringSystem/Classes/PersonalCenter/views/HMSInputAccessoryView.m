//
//  HMSInputAccessoryView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/5.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSInputAccessoryView.h"

@interface HMSInputAccessoryView ()
@property(nonatomic,copy)NSString* textContent;
@property(nonatomic,assign)HMSInputAccessoryBlock finishBlock;
@end
@implementation HMSInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text Block:(HMSInputAccessoryBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        self.textContent = text;
        self.finishBlock = block;
        [self initView];
    }
    return self;
}
- (void)initView{
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, -0.5f);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.3;
    UIFont *labelFont =iPhone5_5s?HMSFOND(16):HMSFOND(17);
    UIFont *confimFont = iPhone5_5s?HMSFOND(17):HMSFOND(18);
    
//    [self bottomLineforViewWithColor:MLDividerLineColor];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 0, self.height)];
    label.font = labelFont;
    label.textColor = [UIColor blackColor];
    label.text = self.textContent;
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    
    CGFloat btnWidth = [NSString widthWithString:@"确定" andStrFont:confimFont andMaxSize:CGSizeMake(100, self.height)];
    UIButton* confim = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-btnWidth-20, 0, btnWidth, self.height)];
    CGFloat labelWidth = [NSString widthWithString:self.textContent andStrFont:labelFont andMaxSize:CGSizeMake(self.width-25-10-btnWidth, self.height)];
    label.width = labelWidth;
    confim.titleLabel.font = labelFont;
    [confim setTitle:@"确定" forState:UIControlStateNormal];
    [confim setTitleColor:HMSThemeColor forState:UIControlStateNormal];
    //    [confim setImage:[UIImage imageNamed:@"rightIcon"] forState:(UIControlStateNormal)];
    [confim addTarget:self action:@selector(confimClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:confim];
    
}
- (void)confimClick{
    self.finishBlock();
}

@end

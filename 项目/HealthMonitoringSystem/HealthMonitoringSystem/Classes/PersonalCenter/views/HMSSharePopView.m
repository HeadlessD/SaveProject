//
//  HMSSharePopView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/13.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSharePopView.h"

@interface HMSSharePopView ()
@property (nonatomic,strong)UIView *backView;

@end
@implementation HMSSharePopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView*  blur = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
            blur.frame = self.frame;
            [self addSubview:blur];
        }else {
            self.backgroundColor = HMSCustomARGBColor(0, 0, 0, 0.7);
        }
        
        UIView *clickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:clickView];
        UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disShow)];
        [clickView addGestureRecognizer:tapG];
        
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, 300, 200)];
        self.backView.centerX= self.width *0.5;
        self.backView.centerY = self.height*0.5;
        self.backView.layer.cornerRadius = 5;
        self.backView.clipsToBounds =YES;
        self.backView.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.backView];
        
        
        UILabel *titleLabel = [UILabel  labelWithTitle:@"分享到" Color:[UIColor blackColor] Font:HMSFOND(16) textAlignment:NSTextAlignmentCenter];
        titleLabel.frame = CGRectMake(0, 15, self.backView.width, 16);
        [self.backView addSubview:titleLabel];
        
        NSArray *iconArray = @[@"shareIcon_wechat",@"shareIcon_friendShip",@"shareIcon_QQ",@"shareIcon_sina"];
        NSArray *titleArray = @[@"微信好友",@"微信朋友圈",@"QQ好友",@"新浪微博"];
        CGFloat width = self.backView.width/4;
        CGFloat centerXoffset = width * 0.5;
        CGFloat btnY = CGRectGetMaxY(titleLabel.frame)+15;
        CGFloat btnWidth = 42;
        CGFloat titleY = CGRectGetMaxY(titleLabel.frame)+15+42+15;
        for (int i =0; i<titleArray.count; i++) {
            UIButton *iconBtn = [UIButton buttonWithImage:[UIImage imageNamed:iconArray[i]] highLightImg:nil BGColor:nil clickAction:@selector(sharBtnClick:) viewController:self cornerRadius:0];
            iconBtn.frame = CGRectMake(0, btnY, btnWidth, btnWidth);
            iconBtn.centerX = width * i +centerXoffset;
            iconBtn.tag = i;
            [self.backView addSubview:iconBtn];
            
            UILabel *textLabel = [UILabel labelWithTitle:titleArray[i] Color:[UIColor blackColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentCenter];
            textLabel.frame = CGRectMake(width * i, titleY, width, 15);
            [self.backView addSubview:textLabel];
        }
        
        
        UIButton *cancelBtn =[UIButton buttonWithTitle:@"取消" font:HMSFOND(16) TitleColor:[UIColor blackColor] BGColor:nil clickAction:@selector(cancelBtnClick:) viewController:self cornerRadius:0];
        cancelBtn.frame = CGRectMake(0, self.backView.height-50, self.backView.width, 50);
        [cancelBtn topLineforViewWithColor:HMSThemeBackgroundColor];
        [cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageWithColor:HMSCustomColor(190, 190, 190)] forState:UIControlStateHighlighted];
        [self.backView addSubview:cancelBtn];
        
    }
    
    return self;
}


-(void)sharBtnClick:(UIButton *)btn
{
    if (self.popViewSelectAction) {
        self.popViewSelectAction(btn.tag);
        [self disShow];
    }
}

-(void)cancelBtnClick:(UIButton *)btn
{
    [self disShow];
}

-(void)disShow
{
    WS(ws);
    [UIView animateWithDuration:0.2 animations:^{
        ws.backView.y = ws.height;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            ws.alpha = 0;
        }completion:^(BOOL finished) {
            [ws removeFromSuperview];
        }];
    }];
}

-(void)show
{
    self.alpha = 0;
    WS(ws);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        ws.alpha = 1;
        
    }completion:^(BOOL finished) {

    }];
    
}

@end

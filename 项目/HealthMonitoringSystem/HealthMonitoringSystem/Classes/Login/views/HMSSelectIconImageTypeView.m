//
//  HMSSelectIconImageTypeView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/3.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSelectIconImageTypeView.h"

@interface HMSSelectIconImageTypeView ()

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIButton *camreBtn;

@property (nonatomic,strong)UIButton *albumBtn;

@property (nonatomic,strong)UILabel *camreLabel;

@property (nonatomic,strong)UILabel *albumLabel;


@end
@implementation HMSSelectIconImageTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title oneImage:(UIImage *)oneImage oneText:(NSString *)oneText oneTextColor:(UIColor *)oneTextColor twoImage:(UIImage *)twoImage twoText:(NSString *)twoText twoTextColor:(UIColor *)twoTextColor
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView*  blur = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
            blur.frame = self.frame;
            [self addSubview:blur];
            
            
        }else {
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        }
        
        UIView *hiddenView = [[UIView alloc]initWithFrame:self.frame];
        [self addSubview:hiddenView];
        UITapGestureRecognizer *tapGR =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
        [hiddenView addGestureRecognizer:tapGR];
        
        self.sliderBGView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, 0)];
        self.sliderBGView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sliderBGView];
        
        self.titleLabel = [UILabel labelWithTitle:title Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
        self.titleLabel.frame = CGRectMake(10, 10, 100, 20);
        [self.sliderBGView addSubview:self.titleLabel];
        
        self.camreBtn = [UIButton buttonWithImage:oneImage highLightImg:[UIImage imageNamed:@""] BGColor:nil clickAction:@selector(camreBtnClick:) viewController:self cornerRadius:45];
        self.camreBtn.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+15, 90, 90);
        self.camreBtn.centerX = self.sliderBGView.width*0.25+20;
        [self.sliderBGView addSubview:self.camreBtn];
        
        self.albumBtn = [UIButton buttonWithImage:twoImage highLightImg:[UIImage imageNamed:@""] BGColor:nil clickAction:@selector(albumBtnClick:) viewController:self cornerRadius:45];
        self.albumBtn.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+15, 90, 90);
        self.albumBtn.centerX = self.sliderBGView.width*0.75-20;
        [self.sliderBGView addSubview:self.albumBtn];
        
        self.camreLabel =[UILabel labelWithTitle:oneText Color:[UIColor blackColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentCenter];
        if (oneTextColor) {
            self.camreLabel.textColor = oneTextColor;
        }
        self.camreLabel.frame = CGRectMake(0, CGRectGetMaxY(self.camreBtn.frame)+8, 50, 20);
        self.camreLabel.centerX =self.camreBtn.centerX;
        [self.sliderBGView addSubview:self.camreLabel];
        
        self.albumLabel =[UILabel labelWithTitle:twoText Color:[UIColor blackColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentCenter];
        if (twoTextColor) {
            self.albumLabel.textColor = twoTextColor;
        }
        self.albumLabel.frame = CGRectMake(0, CGRectGetMaxY(self.camreBtn.frame)+8, 50, 20);
        self.albumLabel.centerX =self.albumBtn.centerX;
        [self.sliderBGView addSubview:self.albumLabel];
        
        self.sliderBGView.height = CGRectGetMaxY(self.albumLabel.frame)+20;
    }
    return self;
}


-(void)initView
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView*  blur = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        blur.frame = self.frame;
        [self addSubview:blur];
        
        
    }else {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    }
    
    UIView *hiddenView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:hiddenView];
    UITapGestureRecognizer *tapGR =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [hiddenView addGestureRecognizer:tapGR];
    
    self.sliderBGView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, 0)];
    self.sliderBGView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.sliderBGView];
    
    self.titleLabel = [UILabel labelWithTitle:@"设置头像" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    self.titleLabel.frame = CGRectMake(10, 10, 100, 20);
    [self.sliderBGView addSubview:self.titleLabel];
    
    self.camreBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"login_camera"] highLightImg:[UIImage imageNamed:@""] BGColor:nil clickAction:@selector(camreBtnClick:) viewController:self cornerRadius:45];
    self.camreBtn.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+15, 90, 90);
    self.camreBtn.centerX = self.sliderBGView.width*0.25+20;
    [self.sliderBGView addSubview:self.camreBtn];
    
    self.albumBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"login_ album"] highLightImg:[UIImage imageNamed:@""] BGColor:nil clickAction:@selector(albumBtnClick:) viewController:self cornerRadius:45];
    self.albumBtn.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+15, 90, 90);
    self.albumBtn.centerX = self.sliderBGView.width*0.75-20;
    [self.sliderBGView addSubview:self.albumBtn];
    
    self.camreLabel =[UILabel labelWithTitle:@"拍照" Color:[UIColor blackColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentCenter];
    self.camreLabel.frame = CGRectMake(0, CGRectGetMaxY(self.camreBtn.frame)+8, 50, 20);
    self.camreLabel.centerX =self.camreBtn.centerX;
    [self.sliderBGView addSubview:self.camreLabel];
    
    self.albumLabel =[UILabel labelWithTitle:@"相册" Color:[UIColor blackColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentCenter];
    self.albumLabel.frame = CGRectMake(0, CGRectGetMaxY(self.camreBtn.frame)+8, 50, 20);
    self.albumLabel.centerX =self.albumBtn.centerX;
    [self.sliderBGView addSubview:self.albumLabel];
    
    self.sliderBGView.height = CGRectGetMaxY(self.albumLabel.frame)+20;
    
}

-(void)camreBtnClick:(UIButton *)btn
{
    if (self.selectType) {
        self.selectType(HMSSelectIconImageTypeOne);
        [self hiddenView];
    }
    if (self.selectTypeNoneAction) {
        self.selectTypeNoneAction(HMSSelectIconImageTypeOne);
    }
}
-(void)albumBtnClick:(UIButton *)btn
{
    if (self.selectType) {
        self.selectType(HMSSelectIconImageTypeTwo);
        [self hiddenView];
    }
    if (self.selectTypeNoneAction) {
        self.selectTypeNoneAction(HMSSelectIconImageTypeTwo);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)show{

    self.alpha =0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha =1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.sliderBGView.y-=self.sliderBGView.height;
        } completion:nil];
    }];
   
}

-(void)hiddenView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderBGView.y+=self.sliderBGView.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}




@end

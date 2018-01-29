//
//  HMSFriendPopView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSFriendPopView.h"
#import "HMSOldManModel.h"
#import <UIImageView+WebCache.h>

@interface HMSFriendPopView ()
@property (nonatomic,strong) UIImageView *headerImgView;

@property (nonatomic,strong) UILabel *nikeNameLabel;

@property (nonatomic,strong) UIImageView *sexImgView;

@property (nonatomic,strong) UILabel *birthdayLabel;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) HMSOldManFriendModel *friendM;
@end
@implementation HMSFriendPopView

-(instancetype)initWithFrame:(CGRect)frame friendModel:(HMSOldManFriendModel *)friendModel
{
    if (self = [super initWithFrame:frame]) {
        
        self.friendM = friendModel;
        
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
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
        self.backView.layer.cornerRadius = 5;
        self.backView.centerX= self.width *0.5;
        self.backView.centerY = self.height*0.5-30;
        self.backView.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.backView];
        
        self.headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 90, 90)];
        self.headerImgView.layer.cornerRadius = 45;
        self.headerImgView.clipsToBounds=YES;
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:friendModel.avatar] placeholderImage:[UIImage imageNamed:[friendModel.sex isEqualToString:@"0"]?@"defaul_manHeaderImg":@"defaul_womanHeaderImg"]];
        [self.backView addSubview:self.headerImgView];
        
        self.nikeNameLabel = [UILabel labelWithTitle:friendModel.username Color:[UIColor blackColor] Font:HMSFOND(17) textAlignment:NSTextAlignmentLeft];
        self.nikeNameLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImgView.frame)+20, self.headerImgView.y+12, self.width-(CGRectGetMaxX(self.headerImgView.frame)+20)-20, 17);
        [self.backView addSubview:self.nikeNameLabel];
        
        self.sexImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.nikeNameLabel.x, CGRectGetMaxY(self.nikeNameLabel.frame)+12, 20, 20)];
        self.sexImgView.image = [UIImage imageNamed:[friendModel.sex isEqualToString:@"0"]?@"personalCenter_man":@"personalCenter_woman"];
        [self.backView addSubview:self.sexImgView];
        
        self.birthdayLabel = [UILabel labelWithTitle:friendModel.birthday Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
        self.birthdayLabel.frame = CGRectMake(self.nikeNameLabel.x, CGRectGetMaxY(self.sexImgView.frame)+12, self.width-(CGRectGetMaxX(self.headerImgView.frame)+20)-20, 12);
        [self.backView addSubview:self.birthdayLabel];
        
        UIButton *deleteBtn =[UIButton buttonWithTitle:@"删除" font:HMSFOND(16) TitleColor:[UIColor whiteColor] BGColor:nil clickAction:@selector(deleteBtnClick:) viewController:self cornerRadius:0];
        deleteBtn.frame = CGRectMake(0, CGRectGetMaxY(self.headerImgView.frame)+30, self.backView.width, 50);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"oldMan_popViewBtn"] forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"oldMan_popViewBtn_select"] forState:UIControlStateHighlighted];
        [self.backView addSubview:deleteBtn];
    }
    return self;
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        if (self.deleteFriend) {
            self.deleteFriend(self.friendM.friend_table_id);
            [self disShow];
        }
    }else
    {
        
    }
}
-(void)deleteBtnClick:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除吗?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"删除",@"取消", nil];
    alert.tag = 1000;
    [alert show];
    
   
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

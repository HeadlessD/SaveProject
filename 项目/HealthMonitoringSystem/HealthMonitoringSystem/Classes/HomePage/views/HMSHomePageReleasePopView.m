//
//  HMSHomePageReleasePopView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/17.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageReleasePopView.h"

@interface HMSHomePageReleasePopView ()
@property (nonatomic,strong)UIView *cameraView;

@property (nonatomic,strong)UIView *pictureView;

@property (nonatomic,strong)UIView *characterView;

@property (nonatomic,strong)UIButton *closeBtn;
@end
@implementation HMSHomePageReleasePopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        NSArray *iconArray = @[@"homepagePopView_Camera",@"homepagePopView_Picture",@"homepagePopView_Character"];
        NSArray *titleArray = @[@"拍照",@"图文",@"文字"];
        CGFloat titleWidth = (self.width-20)/3;
        
        for (int i =0; i<titleArray.count; i++) {
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10+titleWidth*i, self.height , titleWidth, 105)];
            [self addSubview:backView];
            
            UILabel *titleLabel = [UILabel labelWithTitle:titleArray[i] Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentCenter];
            titleLabel.frame = CGRectMake(0, backView.height-20, titleWidth, 20);
            [backView addSubview:titleLabel];
            
            UIButton *btn = [UIButton buttonWithImage:[UIImage imageNamed:iconArray[i]] highLightImg:nil BGColor:nil clickAction:@selector(btnClickAction:) viewController:self cornerRadius:0];
            btn.frame = CGRectMake(0, 0, 75, 75);
            btn.centerX = backView.width*0.5;
            [backView addSubview:btn];
            btn.tag = i;
            switch (i) {
                case 0:
                {
                    self.cameraView = backView;
                }
                    break;
                case 1:
                {
                    self.pictureView = backView;
                }
                    break;
                case 2:
                {
                    self.characterView = backView;
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        self.closeBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"homeoagePopView_close"] highLightImg:nil BGColor:nil clickAction:@selector(closeBtnAction:) viewController:self cornerRadius:0];
        self.closeBtn.frame = CGRectMake(0, self.height *0.5+25, 50, 50);
        self.closeBtn.centerX = self.width*0.5;
        self.closeBtn.alpha =0;
        [self addSubview:self.closeBtn];
    }
    return self;
}

-(void)btnClickAction:(UIButton *)btn
{
    if (self.popViewSelectAction) {
        self.popViewSelectAction(btn.tag);
    }
    [self disShow];
}

-(void)closeBtnAction:(UIButton *)btn
{
    [self disShowWithAnimation];
}

-(void)disShowWithAnimation
{
    WS(ws);
    
    [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
        ws.cameraView.y = ws.height;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.05 options:0 animations:^{
        ws.pictureView.y = ws.height;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.1 options:0 animations:^{
        ws.characterView.y = ws.height;
        ws.closeBtn.alpha =0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            ws.alpha = 0;
        }completion:^(BOOL finished) {
            [ws removeFromSuperview];
        }];
    }];
  
}
-(void)disShow
{
    WS(ws);
    [UIView animateWithDuration:0.3 animations:^{
        ws.alpha = 0;
    }completion:^(BOOL finished) {
        [ws removeFromSuperview];
    }];
}

-(void)show
{
    self.alpha = 0;
    WS(ws);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.15 animations:^{
        ws.alpha = 1;
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6 options:0 animations:^{
            ws.cameraView.y = ws.height *0.5 -105;
        } completion:nil];
        [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:0 animations:^{
             ws.pictureView.y = ws.height *0.5 -105;
        } completion:nil];
        [UIView animateWithDuration:0.3 delay:0.2 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:0 animations:^{
             ws.characterView.y = ws.height *0.5 -105;
            ws.closeBtn.alpha =1;
        } completion:^(BOOL finished) {
            
        }];
        
        
    }];
    
}

@end

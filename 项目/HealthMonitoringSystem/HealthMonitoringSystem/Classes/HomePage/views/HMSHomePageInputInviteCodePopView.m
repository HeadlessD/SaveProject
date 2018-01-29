//
//  HMSHomePageInputInviteCodePopView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/24.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageInputInviteCodePopView.h"

@interface HMSHomePageInputInviteCodePopView ()
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITextField *inviteCodeTF;

@property(nonatomic,assign)CGFloat differenceValue;
@end
@implementation HMSHomePageInputInviteCodePopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
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
        UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView)];
        [clickView addGestureRecognizer:tapG];
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, 300, 200)];
        self.backView.centerX= self.width *0.5;
        self.backView.centerY = self.height*0.5-30;
        self.backView.layer.cornerRadius = 5;
        self.backView.clipsToBounds =YES;
        self.backView.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.backView];
        
        
        UILabel *titleLabel = [UILabel labelWithTitle:@"输入邀请码" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
        CGSize titleLSize = [titleLabel.text mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(250, 15)];
        titleLabel.frame = (CGRect){{45,30},titleLSize};
        [self.backView addSubview:titleLabel];
        
        UITextField *inviteCodeTF = [UITextField textFieldWithRect:CGRectMake(titleLabel.x, CGRectGetMaxY(titleLabel.frame)+12, self.backView.width-90, 40) text:nil placeholder:@"邀请码" textColor:[UIColor darkGrayColor] fontSize:15 textAlignment:NSTextAlignmentLeft];
        [self.backView addSubview:inviteCodeTF];
        self.inviteCodeTF = inviteCodeTF;
        
        UIView *dividerLine = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.x, CGRectGetMaxY(inviteCodeTF.frame), inviteCodeTF.width, 1)];
        dividerLine.backgroundColor = HMSThemeDeviderColor;
        [self.backView addSubview:dividerLine];
        
        UILabel *tipisLabel =[UILabel labelWithTitle:@"邀请码在你收到的短信或微信邀请中" Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
        CGSize tipisLabelSize = [tipisLabel.text mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(dividerLine.width, 12)];
        tipisLabel.frame = (CGRect){{titleLabel.x,CGRectGetMaxY(dividerLine.frame)+3},tipisLabelSize};
        [self.backView addSubview:tipisLabel];
        
        
        UIButton *doneBtn =[UIButton buttonWithTitle:@"验证" font:HMSFOND(16) TitleColor:[UIColor blackColor] BGColor:nil clickAction:@selector(doneBtnClick:) viewController:self cornerRadius:0];
        doneBtn.frame = CGRectMake(0, self.backView.height-50, self.backView.width, 50);
        [doneBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [doneBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [doneBtn topLineforViewWithColor:HMSThemeDeviderColor];
        [self.backView addSubview:doneBtn];
        
       
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //监听当键将要退出时
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    return self;
}


-(void)doneBtnClick:(UIButton *)btn
{
    if (self.inviteCodeTF.text.length<=0) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的邀请码"];
        return;
    }
    if (self.popViewAciton) {
        [self endEditing:YES];
        self.popViewAciton(self.inviteCodeTF.text);
        [self disShow];
    }
}
-(void)clickBackView
{
    if (self.inviteCodeTF.isFirstResponder) {
        [self endEditing:YES];
    }else
    {
        [self disShow];
    }
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    
    CGPoint rc = [self.backView convertPoint:self.inviteCodeTF.frame.origin toView:self];
    if ((KScreenHeight - height)<(rc.y+self.inviteCodeTF.height+10)) {
        self.differenceValue =(rc.y+self.inviteCodeTF.height+10)-(KScreenHeight - height);
        [UIView animateWithDuration:0.15 animations:^{
            self.backView.y -= self.differenceValue;
        }];
    }
    
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.differenceValue) {
        [UIView animateWithDuration:0.15 animations:^{
            self.backView.y += self.differenceValue;
        }completion:^(BOOL finished) {
            self.differenceValue = 0;
        }];
    }
    
    
    
}



@end

//
//  HMSLoginVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/29.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSLoginVC.h"
#import "HMSRegisterVC.h"
#import "HMSFindPasswordVC.h"
#import "HMSRegisterTwo.h"

@interface HMSLoginVC ()

@property (nonatomic,strong)UILabel *loginTitle;

@property (nonatomic,strong)UIView *loginTopView;

@property (nonatomic,strong)UITextField *userNameTF;

@property (nonatomic,strong)UITextField *passwordTF;

@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIButton *registerBtn;

@property (nonatomic,strong)UIButton *forgetBtn;

@property (nonatomic,strong)UILabel *tipsLabel;

@property (nonatomic,strong)UIView *dividerLine;

@property (nonatomic,strong)UIButton *sendVerificationBtn;

@property (nonatomic,strong)UIButton *verificationLoginBtn;

@property (nonatomic,strong)UIButton *passwordLoginBtn;

@property (nonatomic,strong)UIView *loginBottomView;

@property (nonatomic,strong)UIView *sliderView;


@end

@implementation HMSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
}

#pragma  mark ---------------------------初始化UI界面---------------------
-(void)initView{
    WS(ws);
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    bgImgView.image = [UIImage imageNamed:@"login_backgroundPic"];
    bgImgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgImgView];
    
    self.loginTitle = [UILabel labelWithTitle:@"登录" Color:[UIColor blackColor] Font:HMSFOND(18) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.loginTitle];
    [self.loginTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.offset(40);
        make.centerX.equalTo(ws.view);
    }];
    
    
    self.loginTopView = [UIView new];
    self.loginTopView.backgroundColor = [UIColor whiteColor];
    self.loginTopView.layer.cornerRadius = 5;
    [self.view addSubview:self.loginTopView];
    [self.loginTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(100);
        make.left.equalTo(ws.view).with.offset(10);
        make.width.mas_equalTo(@(KScreenWidth-20));
    }];
    
    self.userNameTF = [UITextField textFieldWithPlaceholder:@"请输入手机号码" Font:HMSFOND(15) TextColor:UIColorFromRGB(0x252e35) HorderColor:
                              UIColorFromRGB(0x8e9fa8) BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    self.userNameTF.keyboardType = UIKeyboardTypePhonePad;
    [self.loginTopView addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTopView).with.offset(5);
        make.left.equalTo(self.loginTopView).with.offset(10);
        make.right.equalTo(self.loginTopView).with.offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    self.dividerLine = [UIView new];
    self.dividerLine.backgroundColor =UIColorFromRGB(0x8e9fa8);
    [self.loginTopView addSubview:self.dividerLine];
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTF.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@0.5);
        make.left.equalTo(self.loginTopView);
        make.right.equalTo(self.loginTopView);
    }];
    
    self.passwordTF = [UITextField textFieldWithPlaceholder:@"输入密码(至少6位)" Font:HMSFOND(15) TextColor:UIColorFromRGB(0x252e35) HorderColor:UIColorFromRGB(0x8e9fa8) BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    self.passwordTF.secureTextEntry=YES;
    [self.loginTopView addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dividerLine.mas_bottom).with.offset(5);
        make.left.equalTo(self.userNameTF.mas_left);
        make.right.equalTo(self.userNameTF.mas_right);
        make.height.mas_equalTo(@40);
    }];
    
    self.sendVerificationBtn = [UIButton buttonWithTitle:@"发送验证码" font:HMSFOND(12) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(sendVerificationBtnClick:) viewController:self cornerRadius:15];
    self.sendVerificationBtn.hidden =YES;
    [self.loginTopView addSubview:self.sendVerificationBtn];
    [self.sendVerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.passwordTF.mas_bottom).with.offset(-5);
        make.right.equalTo(self.passwordTF.mas_right);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@90);
    }];
    
    self.loginBtn = [UIButton buttonWithTitle:@"登录" font:HMSFOND(15) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(loginBtnClick:) viewController:self cornerRadius:5];
    [self.loginTopView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).with.offset(10);
        make.left.equalTo(self.userNameTF.mas_left);
        make.right.equalTo(self.userNameTF.mas_right);
        make.height.mas_equalTo(@44);
    }];
    
    self.forgetBtn = [UIButton buttonWithTitle:@"忘记密码?" font:HMSFOND(12) TitleColor:UIColorFromRGB(0x8e9fa8) BGColor:[UIColor whiteColor] clickAction:@selector(forgetBtnClick:) viewController:self cornerRadius:0];
    [self.loginTopView addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(5);
        make.left.equalTo(self.userNameTF.mas_left);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@65);
    }];
    
    self.tipsLabel = [UILabel labelWithTitle:@"账号或密码错误，请重新输入" Color:UIColorFromRGB(0xfb734f) Font:HMSFOND(12) textAlignment:NSTextAlignmentRight];
    [self.loginTopView addSubview:self.tipsLabel];
    self.tipsLabel.hidden = YES;
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(5);
        make.right.equalTo(self.userNameTF);
        make.height.mas_equalTo(@20);
    }];
    
    
    [self.loginTopView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tipsLabel.mas_bottom).with.offset(15);
    }];
   
    
    
    
    //切换密码登录
    self.loginBottomView = [UIView new];
    self.loginBottomView.backgroundColor = UIColorFromRGB(0x0d47a1);
    self.loginBottomView.layer.cornerRadius = 40*0.5;
    [self.view addSubview:self.loginBottomView];
    [self.loginBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTopView.mas_bottom).with.offset(12);
        make.left.equalTo(self.loginTopView.mas_left).with.offset(60);
        make.right.equalTo(self.loginTopView.mas_right).with.offset(-60);
        make.height.mas_equalTo(@40);
    }];
    
    self.sliderView = [[UIView alloc]init];
    self.sliderView.backgroundColor = [UIColor whiteColor];
    self.sliderView.layer.cornerRadius = (40-6)*0.5;
    [self.loginBottomView addSubview:self.sliderView];
   
    
    self.passwordLoginBtn = [UIButton buttonWithTitle:@"密码登录" font:HMSFOND(13) TitleColor:UIColorFromRGB(0x1976d2) BGColor:nil clickAction:@selector(passwordLoginBtnClick:) viewController:self cornerRadius:(40-6)*0.5];
    [self.loginBottomView addSubview:self.passwordLoginBtn];
    
    [self.passwordLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBottomView.mas_top).with.offset(3);
        make.left.equalTo(self.loginBottomView.mas_left).with.offset(3);
        make.bottom.equalTo(self.loginBottomView.mas_bottom).with.offset(-3);
        make.width.equalTo(self.loginBottomView.mas_width).multipliedBy(0.45f);
    }];
    
   
    
    self.verificationLoginBtn = [UIButton buttonWithTitle:@"验证码登录" font:HMSFOND(13) TitleColor:[UIColor whiteColor] BGColor:nil clickAction:@selector(verificationLoginBtnClick:) viewController:self cornerRadius:(40-6)*0.5];
    [self.loginBottomView addSubview:self.verificationLoginBtn];
    [self.verificationLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBottomView.mas_top).with.offset(3);
        make.bottom.equalTo(self.loginBottomView.mas_bottom).with.offset(-3);
        make.right.equalTo(self.loginBottomView.mas_right).with.offset(-3);
        
        make.width.equalTo(self.loginBottomView.mas_width).multipliedBy(0.45f);
    }];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginBottomView);
        make.width.equalTo(self.loginBottomView.mas_width).multipliedBy(0.45f);
        make.height.mas_equalTo(@34);
        make.centerX.equalTo(self.passwordLoginBtn);
    }];
    
    self.registerBtn = [UIButton buttonWithTitle:@"注册" font:HMSFOND(15) TitleColor:[UIColor whiteColor] BGColor:[UIColor clearColor] clickAction:@selector(registerBtnClick:) viewController:self cornerRadius:0];
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderView.mas_bottom).with.offset(25);
        make.width.mas_offset(@100);
        make.height.mas_equalTo(@30);
        make.centerX.equalTo(ws.view);
    }];
    
}



//登录
-(void)loginBtnClick:(UIButton *)btn
{
    self.tipsLabel.hidden =YES;
    if (![HMSUtils userNameIsPhone:self.userNameTF.text]) {
        self.tipsLabel.text =@"账号格式错误,请重新输入";
        self.tipsLabel.hidden =NO;
        return;
    }
    if(self.sendVerificationBtn.hidden)
    {
        if (![HMSUtils userPwdLengthMatch:self.passwordTF.text]) {
            self.tipsLabel.text =@"密码格式错误,请重新输入";
            self.tipsLabel.hidden =NO;
            return;
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mobile"] = self.userNameTF.text;
        params[@"password"] = [HMSUtils escapedString:self.passwordTF.text];
        [SVProgressHUD show];
        
        [HMSNetWorkManager requestJsonDataWithPath:@"user/login-by-password" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            [SVProgressHUD dismiss];
            
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
           
            if([error isEqualToString:@""]){
                HMSAccount *account= [HMSAccount mj_objectWithKeyValues:respondObj[@"data"]];
                [account save];
                
                [account getUserInfoSuccess:^{
                    
                    [account save];
                    
                    [HMSUtils changeRootVCtoHomeVC];
                } failure:^(NSString *error) {
                    [SVProgressHUD showErrorWithStatus:error];
                }];
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
        
    }else
    {
        if (self.passwordTF.text.length==0) {
            self.tipsLabel.text =@"验证码不能为空";
            self.tipsLabel.hidden =NO;
            return;
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mobile"] = self.userNameTF.text;
        params[@"code"] = self.passwordTF.text;
        [SVProgressHUD show];
        
        [HMSNetWorkManager requestJsonDataWithPath:@"user/login-by-code" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            [SVProgressHUD dismiss];
            
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                
                
                HMSAccount *account= [HMSAccount mj_objectWithKeyValues:respondObj[@"data"]];
                [account save];
                
                [account getUserInfoSuccess:^{
                    [account save];
                    
                    if ([account.is_inited isEqualToString:@"0"]) {
                        HMSRegisterTwo *registTwoVC = [[HMSRegisterTwo alloc]init];
                        registTwoVC.pageType = HMSRegisterTwoTypeLoginFirst;
                        registTwoVC.phoneNumber = self.userNameTF.text;
                        [self.navigationController pushViewController:registTwoVC animated:YES];
                    }else
                    {
                        [HMSUtils changeRootVCtoHomeVC];
                    }
                    
                } failure:^(NSString *error) {
                    [SVProgressHUD showErrorWithStatus:error];
                }];
                
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    }
}
//注册
-(void)registerBtnClick:(UIButton *)btn
{
    HMSRegisterVC *registVC = [[HMSRegisterVC alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
    
}
//忘记密码
-(void)forgetBtnClick:(UIButton *)btn
{
    HMSFindPasswordVC *findVC = [[HMSFindPasswordVC alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
}

//
-(void)passwordLoginBtnClick:(UIButton *)btn
{
    [self.sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginBottomView);
        make.width.equalTo(self.loginBottomView.mas_width).multipliedBy(0.45f);
        make.height.mas_equalTo(@34);
        make.centerX.equalTo(self.passwordLoginBtn);
    }];
    [UIView animateWithDuration:0.15 animations:^{
        self.sendVerificationBtn.hidden = YES;
        
        [self.sliderView.superview layoutIfNeeded];
    }];
    self.passwordTF.text =nil;
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.placeholder = @"输入密码(至少6位)";
    [btn setTitleColor:UIColorFromRGB(0x1976d2) forState:UIControlStateNormal];
    [self.verificationLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//切换到验证码登录
-(void)verificationLoginBtnClick:(UIButton *)btn
{
    [self.sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginBottomView);
        make.width.equalTo(self.loginBottomView.mas_width).multipliedBy(0.45f);
        make.height.mas_equalTo(@34);
        make.centerX.equalTo(self.verificationLoginBtn);
    }];
    [UIView animateWithDuration:0.15 animations:^{
        self.sendVerificationBtn.hidden = NO;
        
        [self.sliderView.superview layoutIfNeeded];
        
    }];
    self.passwordTF.text =nil;
    self.passwordTF.secureTextEntry = NO;
    self.passwordTF.placeholder = @"输入验证码";
    [btn setTitleColor:UIColorFromRGB(0x1976d2) forState:UIControlStateNormal];
    [self.passwordLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//发送验证码
-(void)sendVerificationBtnClick:(UIButton *)btn
{
    self.tipsLabel.hidden = YES;
    if (![HMSUtils userNameIsPhone:self.userNameTF.text]) {
        self.tipsLabel.text = @"手机号格式错误,请重新输入";
        self.tipsLabel.hidden = NO;
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.userNameTF.text;
    params[@"source_type"] = @"login";
    [HMSNetWorkManager requestJsonDataWithPath:@"user/send-mobile-code" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            [SVProgressHUD showSuccessWithStatus:@"请输入收到的验证码"];
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
    
    [self timePadding];
}







- (void)timePadding{
    
    __block int timeout=60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
   	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
   	dispatch_source_set_event_handler(_timer, ^{
        if(timeout<0){
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.sendVerificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.sendVerificationBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout ;//% 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.sendVerificationBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.sendVerificationBtn.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

@end

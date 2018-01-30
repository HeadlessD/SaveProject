//
//  HMSFindPasswordVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/3.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSFindPasswordVC.h"
#import "HMSSettingPasswordVC.h"

@interface HMSFindPasswordVC ()
@property (nonatomic,strong) UIView *sendSMSTipsView;

@property (nonatomic,strong) UILabel *sendSMSTipsLabel;

@property (nonatomic,strong) UIView *phoneNumTFView;

@property (nonatomic,strong) UITextField *phoneNumTF;

@property (nonatomic,strong) UIButton *sendVerificationBtn;

@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,strong) UIButton *doneBtn;

@property (nonatomic,strong) NSString *phoneNumber;
@end

@implementation HMSFindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"找回密码";
    self.view.backgroundColor =HMSThemeBackgroundColor;
    
    [self initView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)initView
{
    WS(ws);
    self.sendSMSTipsView = [[UIView alloc]init];
    self.sendSMSTipsView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.sendSMSTipsView];
    [self.sendSMSTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(ws.view).with.offset(10);
        make.right.equalTo(ws.view).with.offset(-10);
    }];
    
    self.sendSMSTipsLabel = [UILabel labelWithTitle:@"短信验证码已发送到\n" Color:UIColorFromRGB(0x1976d2) Font:HMSFOND(15) textAlignment:NSTextAlignmentCenter];
    self.sendSMSTipsLabel.numberOfLines = 0;
    [self.sendSMSTipsView addSubview:self.sendSMSTipsLabel];
    [self.sendSMSTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sendSMSTipsView).with.offset(20);
        make.centerX.equalTo(self.sendSMSTipsView);
        make.height.mas_equalTo(@40);
    }];
    
    self.phoneNumTFView = [[UIView alloc]init];
    self.phoneNumTFView.backgroundColor =[UIColor whiteColor];
    self.phoneNumTFView.layer.cornerRadius = 3;
    [self.view addSubview:self.phoneNumTFView];
    [self.phoneNumTFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sendSMSTipsView.mas_bottom);
        make.left.equalTo(self.sendSMSTipsView.mas_left);
        make.right.equalTo(self.sendSMSTipsView.mas_right);
        make.height.mas_equalTo(@44);
    }];
    
    self.phoneNumTF = [UITextField textFieldWithPlaceholder:@"输入手机号码" Font:HMSFOND(15) TextColor:UIColorFromRGB(0x252e35) HorderColor:UIColorFromRGB(0x8e9fa8) BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    self.phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    [self.phoneNumTFView addSubview:self.phoneNumTF];
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneNumTFView);
        make.left.equalTo(self.phoneNumTFView).with.offset(15);
        make.right.equalTo(self.phoneNumTFView).with.offset(-15);
        make.height.mas_equalTo(@40);
    }];
    
    self.sendVerificationBtn = [UIButton buttonWithTitle:@"发送验证码" font:HMSFOND(12) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(sendVerificationBtnClick:) viewController:self cornerRadius:15];
    self.sendVerificationBtn.hidden = YES;
    [self.phoneNumTFView addSubview:self.sendVerificationBtn];
    [self.sendVerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.phoneNumTF.mas_bottom).with.offset(-5);
        make.right.equalTo(self.phoneNumTF.mas_right);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@90);
    }];
    
    self.tipsLabel = [UILabel labelWithTitle:@"手机格式错误,请重新输入" Color:UIColorFromRGB(0xfb734f) Font:HMSFOND(12) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.tipsLabel];
    self.tipsLabel.hidden = YES;
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumTFView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.tipsLabel.superview);
        make.height.mas_equalTo(@20);
    }];
    
    self.doneBtn = [UIButton buttonWithTitle:@"确定" font:HMSFOND(15) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(doneBtnClick:) viewController:self cornerRadius:5];
    [self.view addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.phoneNumTFView).with.offset(15);
        make.right.equalTo(self.phoneNumTFView).with.offset(-15);
        make.height.mas_equalTo(@40);
    }];
}



-(void)sendVerificationBtnClick:(UIButton *)btn
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNumber;
    params[@"source_type"] = @"reset_pass";
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

-(void)doneBtnClick:(UIButton *)btn
{
    self.tipsLabel.hidden = YES;
    if(self.sendVerificationBtn.hidden)
    {
        if (![HMSUtils userNameIsPhone:self.phoneNumTF.text]) {
            self.tipsLabel.text = @"手机号格式错误,请重新输入";
            self.tipsLabel.hidden = NO;
            return;
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mobile"] = self.phoneNumTF.text;
        [HMSNetWorkManager requestJsonDataWithPath:@"user/verify-mobile" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            [SVProgressHUD dismiss];
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                
                [self.sendSMSTipsView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.sendSMSTipsLabel).with.offset(20);
                }];
                
                [self.phoneNumTFView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.sendSMSTipsView.mas_bottom).with.offset(2);
                }];
                self.sendSMSTipsLabel.text = [NSString stringWithFormat:@"短信验证码已发送到\n%@",self.phoneNumTF.text];
                self.phoneNumber = self.phoneNumTF.text;
                self.phoneNumTF.text = nil;
                self.phoneNumTF.placeholder =@"请输入验证码";
                self.sendVerificationBtn.hidden =NO;
                [UIView animateWithDuration:0.2 animations:^{
                    [self.view layoutIfNeeded];
                }];
                
                [self sendVerificationBtnClick:self.sendVerificationBtn];
                
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
                self.tipsLabel.text = @"当前手机号用户不存在,请先注册";
                self.tipsLabel.hidden = NO;
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
        
        
    }else
    {
        
        if (self.phoneNumTF.text.length==0) {
            self.tipsLabel.text = @"验证码输入错误,请重新输入";
            self.tipsLabel.hidden = NO;
            return;
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mobile"] = self.phoneNumber;
        params[@"code"] = self.phoneNumTF.text;
        [HMSNetWorkManager requestJsonDataWithPath:@"user/verify-mobile-code" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                [SVProgressHUD showSuccessWithStatus:nil];
                HMSSettingPasswordVC *settingPDVC = [[HMSSettingPasswordVC alloc]init];
                settingPDVC.phoneNumber = self.phoneNumber;
                [self.navigationController pushViewController:settingPDVC animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
                self.tipsLabel.text = @"验证码输入错误,请重新输入";
                self.tipsLabel.hidden = NO;
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
        
     
    }
    
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

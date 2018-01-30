//
//  HMSRegisterVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/30.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSRegisterVC.h"
#import "HMSRegisterTwo.h"
@interface HMSRegisterVC ()
@property (nonatomic,strong)UILabel *registerTitle;

@property (nonatomic,strong)UITextField *verificationTF;

@property (nonatomic,strong)UITextField *phoneNumTF;

@property (nonatomic,strong)UIButton *registerBtn;

@property (nonatomic,strong)UIButton *sendVerificationBtn;

@property (nonatomic,strong)UIView *registerTopView;

@property (nonatomic,strong)UIView *dividerLine;

@property (nonatomic,strong)UILabel *registTipsLabel;
@end

@implementation HMSRegisterVC

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
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(8, 22, 50, 40)];
    [backBtn setImage:[[UIImage imageNamed:@"navigationBackWhite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    self.registerTitle = [UILabel labelWithTitle:@"注册" Color:[UIColor blackColor] Font:HMSFOND(18) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.registerTitle];
    [self.registerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.offset(44);
        make.centerX.equalTo(ws.view);
    }];
    
    self.registerTopView = [UIView new];
    self.registerTopView.backgroundColor = [UIColor whiteColor];
    self.registerTopView.layer.cornerRadius = 5;
    [self.view addSubview:self.registerTopView];
    [self.registerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(100);
        make.left.equalTo(ws.view).with.offset(10);
        make.width.mas_equalTo(@(KScreenWidth-20));
    }];
    
    self.phoneNumTF = [UITextField textFieldWithPlaceholder:@"请输入手机号码" Font:HMSFOND(15) TextColor:UIColorFromRGB(0x252e35) HorderColor:
                             UIColorFromRGB(0x8e9fa8) BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    [self.registerTopView addSubview:self.phoneNumTF];
    self.phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerTopView).with.offset(5);
        make.left.equalTo(self.registerTopView).with.offset(10);
        make.right.equalTo(self.registerTopView).with.offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    self.dividerLine = [UIView new];
    self.dividerLine.backgroundColor =UIColorFromRGB(0x8e9fa8);
    [self.registerTopView addSubview:self.dividerLine];
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumTF.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@0.5);
        make.left.equalTo(self.registerTopView);
        make.right.equalTo(self.registerTopView);
    }];
    
    self.verificationTF = [UITextField textFieldWithPlaceholder:@"输入验证码" Font:HMSFOND(15) TextColor:UIColorFromRGB(0x252e35) HorderColor:UIColorFromRGB(0x8e9fa8) BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    self.verificationTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.registerTopView addSubview:self.verificationTF];
    [self.verificationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dividerLine.mas_bottom).with.offset(5);
        make.left.equalTo(self.phoneNumTF.mas_left);
        make.right.equalTo(self.phoneNumTF.mas_right);
        make.height.mas_equalTo(@40);
    }];
    
    
    self.sendVerificationBtn = [UIButton buttonWithTitle:@"发送验证码" font:HMSFOND(12) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(sendVerificationBtnClick:) viewController:self cornerRadius:15];
    [self.registerTopView addSubview:self.sendVerificationBtn];
    [self.sendVerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.verificationTF.mas_bottom).with.offset(-5);
        make.right.equalTo(self.verificationTF.mas_right);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@90);
    }];
    
    self.registerBtn = [UIButton buttonWithTitle:@"注册" font:HMSFOND(15) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(registerBtnBtnClick:) viewController:self cornerRadius:5];
    
    [self.registerTopView addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationTF.mas_bottom).with.offset(10);
        make.left.equalTo(self.verificationTF.mas_left);
        make.right.equalTo(self.verificationTF.mas_right);
        make.height.mas_equalTo(@40);
    }];
    
    self.registTipsLabel = [UILabel labelWithTitle:@"验证码输入错误,请重新输入" Color:UIColorFromRGB(0xfb734f) Font:HMSFOND(12) textAlignment:NSTextAlignmentCenter];
    self.registTipsLabel.hidden = YES;
     [self.registTipsLabel addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:@"registTipsLabel_hidden"];
    [self.registerTopView addSubview:self.registTipsLabel];
    [self.registTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerBtn.mas_bottom).with.offset(10);
        make.centerX.equalTo(ws.registerTopView);
        make.height.mas_equalTo(@20);
    }];
    
    [self.registerTopView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.registerBtn).with.offset(10);
    }];
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    WS(ws);
    if ([keyPath isEqualToString:@"hidden"]) {
        NSLog(@"Height is changed! new=%@", [change valueForKey:NSKeyValueChangeNewKey]);
        if (self.registTipsLabel.hidden) {
            [self.registerTopView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.registerTitle.mas_bottom).with.offset(20);
                make.left.equalTo(ws.view).with.offset(10);
                make.width.mas_equalTo(@(KScreenWidth-20));
                make.bottom.equalTo(self.registerBtn.mas_bottom).with.offset(10);
            }];
        }else
        {
            [self.registerTopView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.registerTitle.mas_bottom).with.offset(20);
                make.left.equalTo(ws.view).with.offset(10);
                make.width.mas_equalTo(@(KScreenWidth-20));
                make.bottom.equalTo(self.registTipsLabel.mas_bottom).with.offset(10);
            }];
        }
        [UIView animateWithDuration:0.15 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}


-(void)dealloc
{
    [self.registTipsLabel removeObserver:self forKeyPath:@"hidden"];
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//下一步
-(void)registerBtnBtnClick:(UIButton *)btn
{
    HMSRegisterTwo *registerTwoVC = [HMSRegisterTwo new];
    registerTwoVC.phoneNumber =self.phoneNumTF.text;
    registerTwoVC.pageType = HMSRegisterTwoTypeRegist;
    [self.navigationController pushViewController:registerTwoVC animated:YES];
    self.registTipsLabel.hidden = YES;
    if (![HMSUtils userNameIsPhone:self.phoneNumTF.text]) {
        self.registTipsLabel.text = @"手机号格式错误,请重新输入";
        self.registTipsLabel.hidden = NO;
        return;
    }
    
    if (self.verificationTF.text.length==0) {
        self.registTipsLabel.text = @"验证码输入错误,请重新输入";
        self.registTipsLabel.hidden = NO;
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNumTF.text;
    [HMSNetWorkManager requestJsonDataWithPath:@"user/verify-mobile" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        if([error isEqualToString:@""]){
            
            self.registTipsLabel.text = @"当前手机号已存在";
            self.registTipsLabel.hidden = NO;
            
        }else{
            
            NSMutableDictionary *paramsOne = [NSMutableDictionary dictionary];
            paramsOne[@"mobile"] = self.phoneNumTF.text;
            paramsOne[@"code"] = self.verificationTF.text;
            [HMSNetWorkManager requestJsonDataWithPath:@"user/verify-mobile-code" withParams:paramsOne withMethodType:HttpRequestTypePost success:^(id respondObj) {
                
                NSString *error = [respondObj objectForKey:@"error"];
                NSString *error_message = [respondObj objectForKey:@"error_message"];
                if([error isEqualToString:@""]){
                    [SVProgressHUD showSuccessWithStatus:nil];
                    HMSRegisterTwo *registerTwoVC = [HMSRegisterTwo new];
                    registerTwoVC.phoneNumber =self.phoneNumTF.text;
                    registerTwoVC.pageType = HMSRegisterTwoTypeRegist;
                    [self.navigationController pushViewController:registerTwoVC animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:error_message];
                    self.registTipsLabel.text = @"验证码输入错误,请重新输入";
                    self.registTipsLabel.hidden = NO;
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
            }];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
    
    
   
    
   
}

-(void)sendVerificationBtnClick:(UIButton *)btn
{
    self.registTipsLabel.hidden = YES;
    if (![HMSUtils userNameIsPhone:self.phoneNumTF.text]) {
        self.registTipsLabel.text = @"手机号格式错误,请重新输入";
        self.registTipsLabel.hidden = NO;
        return;
    }
    
  
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNumTF.text;
    params[@"source_type"] = @"regist";
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

-(void)timePadding
{
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

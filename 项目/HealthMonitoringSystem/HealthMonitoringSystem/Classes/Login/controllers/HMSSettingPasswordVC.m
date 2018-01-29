//
//  HMSSettingPasswordVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/3.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSettingPasswordVC.h"

@interface HMSSettingPasswordVC ()
@property (nonatomic,strong)UIView *verificationTFView;

@property (nonatomic,strong)UITextField *verificationTF;

@property (nonatomic,strong)UILabel *tipsLabel;

@property (nonatomic,strong)UIButton *doneBtn;
@end

@implementation HMSSettingPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置密码";
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
    self.verificationTFView = [[UIView alloc]init];
    self.verificationTFView.backgroundColor =[UIColor whiteColor];
    self.verificationTFView.layer.cornerRadius = 3;
    [self.view addSubview:self.verificationTFView];
    [self.verificationTFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(ws.view).with.offset(10);
        make.right.equalTo(ws.view).with.offset(-10);
        make.height.mas_equalTo(@44);
    }];
    
    self.verificationTF = [UITextField textFieldWithPlaceholder:@"输入密码(至少6位)" Font:HMSFOND(15) TextColor:UIColorFromRGB(0x252e35) HorderColor:UIColorFromRGB(0x8e9fa8) BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    [self.verificationTFView addSubview:self.verificationTF];
    [self.verificationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.verificationTFView);
        make.left.equalTo(self.verificationTFView).with.offset(15);
        make.right.equalTo(self.verificationTFView).with.offset(-15);
        make.height.mas_equalTo(@40);
    }];
    
    self.tipsLabel = [UILabel labelWithTitle:@"密码格式错误,请重新输入" Color:UIColorFromRGB(0xfb734f) Font:HMSFOND(12) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.tipsLabel];
    self.tipsLabel.hidden = YES;
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationTFView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.tipsLabel.superview);
        make.height.mas_equalTo(@20);
    }];
    
    
    self.doneBtn = [UIButton buttonWithTitle:@"确定" font:HMSFOND(15) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(doneBtnClick:) viewController:self cornerRadius:5];
    [self.view addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.verificationTFView).with.offset(15);
        make.right.equalTo(self.verificationTFView).with.offset(-15);
        make.height.mas_equalTo(@44);
    }];
}


-(void)doneBtnClick:(UIButton *)btn
{
    self.tipsLabel.hidden =YES;
    if (![HMSUtils userPwdLengthMatch:self.verificationTF.text]) {
        self.tipsLabel.text = @"密码格式错误,请重新输入";
        self.tipsLabel.hidden =NO;
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNumber;
    params[@"password"] = [HMSUtils escapedString:self.verificationTF.text];
    [HMSNetWorkManager requestJsonDataWithPath:@"user/find-password" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功,请登录"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HMSUtils changeRootVCtoLoginVC];
            });
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}
@end

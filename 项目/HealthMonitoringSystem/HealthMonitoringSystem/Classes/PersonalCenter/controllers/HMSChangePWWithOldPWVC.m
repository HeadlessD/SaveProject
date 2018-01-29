//
//  HMSChangePWWithOldPWVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSChangePWWithOldPWVC.h"
#import "HMSOldManPropertyCell.h"

@interface HMSChangePWWithOldPWVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton *saveBtn;

@property (nonatomic,strong)HMSOldManPropertyCell *oldPasswordCell;

@property (nonatomic,strong)HMSOldManPropertyCell *nPasswordCell;

@property(nonatomic,strong) UIGestureRecognizer *tap;
@property(nonatomic,strong) UIView *blur;
@end

@implementation HMSChangePWWithOldPWVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号信息";
    self.view.backgroundColor = HMSThemeBackgroundColor;
    
    self.saveBtn = [self setNavRightItem:@"保存" normalColor:HMSThemeColor highLTColor:nil fontSize:iPhone5_5s?16:17 size:CGSizeMake(60, 40)];
    [self.saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.saveBtn.enabled = NO;
    
     [self initView];
}



-(void)initView
{
    
    UIView *listViewOne = [[UIView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth-24, 100)];
    listViewOne.backgroundColor= [UIColor whiteColor];
    listViewOne.layer.cornerRadius=3;
    [self.view addSubview:listViewOne];
    
    self.oldPasswordCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, 0, listViewOne.width, 50) WithTitle:@"旧密码" text:nil Placeholder:@"请输入旧密码" rightImg:nil cornerType:HMSOldManPropertyCellCornerTop isLine:YES];
    [self.oldPasswordCell.textTitleTF addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.oldPasswordCell.textTitleTF.secureTextEntry =YES;
    self.oldPasswordCell.textTitleTF.delegate = self;
    [listViewOne addSubview:self.oldPasswordCell];
    
    self.nPasswordCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, 50, listViewOne.width, 50) WithTitle:@"新密码" text:nil Placeholder:@"请输入新密码(至少6位)" rightImg:nil cornerType:HMSOldManPropertyCellCornerBottom isLine:NO];
    [self.nPasswordCell.textTitleTF addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.nPasswordCell.textTitleTF.secureTextEntry =YES;
    self.nPasswordCell.textTitleTF.delegate = self;
    [listViewOne addSubview:self.nPasswordCell];
    
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    
    self.blur = [[UIView alloc]init];
    self.blur.backgroundColor = [UIColor blackColor];
    self.blur.frame = self.view.frame;
    self.blur.alpha = 0.0f;
    [self.blur addGestureRecognizer:self.tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.blur];
    
}


-(void)didPressRightItem:(UIButton *)btn
{
    if (self.oldPasswordCell.textTitleTF.text.length<1) {
        [SVProgressHUD showInfoWithStatus:@"请输入旧密码"];
        return;
    }
    if (![HMSUtils userPwdLengthMatch:self.nPasswordCell.textTitleTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入格式正确的新密码"];
        return;
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"password_old"] = [HMSUtils escapedString:self.oldPasswordCell.textTitleTF.text];
    params[@"password_new"] = [HMSUtils escapedString:self.nPasswordCell.textTitleTF.text];
    
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"user/change-password" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            [SVProgressHUD showSuccessWithStatus:@"密码重置成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
    
    
}
-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
    if (self.nPasswordCell.textTitleTF.text.length>0||self.oldPasswordCell.textTitleTF.text.length>0) {
        self.saveBtn.enabled =YES;
    }else
    {
        self.saveBtn.enabled =NO;
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.blur.alpha = 0.7;
    }];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.blur.alpha = 0;
    }];
}
-(void)tapClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.blur.alpha = 0;
        [self.view endEditing:YES];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end

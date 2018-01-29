//
//  HMSRegisterTwo.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/6/30.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSRegisterTwo.h"
#import "HMSSelectIconImageTypeView.h"
@interface HMSRegisterTwo ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIButton *iconBtn;

@property (nonatomic,strong) UILabel *icontips;

@property (nonatomic,strong) UITextField *passwordTF;

@property (nonatomic,strong) UITextField *nikeNameTF;

@property (nonatomic,strong) UIButton *doneRegisterBtn;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIView *dividerLine;

@property (nonatomic,strong) UILabel *tipsOne;

@property (nonatomic,strong) UILabel *tipsTwo;

@property (nonatomic,strong) UIView *bottomLoginView;

@property (nonatomic,strong) HMSSelectIconImageTypeView *iconSelectPopView;

@property (nonatomic,strong) UIImage *iconImg;

@property (nonatomic,strong) NSString *avatar;
@end

@implementation HMSRegisterTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息设置";
    self.avatar =@"";
    [self initView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)initView
{
    WS(ws);
    self.iconBtn = [UIButton buttonWithTitle:nil font:nil TitleColor:nil BGColor:nil clickAction:@selector(iconBtnClick:) viewController:self cornerRadius:45];
    [self.iconBtn setImage:[UIImage imageNamed:@"defaul_manHeaderImg"] forState:UIControlStateNormal];
    [self.view addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(21);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    UIImageView *gearImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personalCenter_headerImgCamera"]];
    [self.view addSubview:gearImageView];
    [gearImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self.iconBtn);
        make.bottom.equalTo(self.iconBtn);
    }];
    
    self.icontips = [UILabel labelWithTitle:@"设置头像" Color:[UIColor grayColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.icontips];
    [self.icontips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconBtn.mas_bottom).with.offset(10);
        make.centerX.equalTo(ws.view);
    }];
    
    
    
    self.bottomView = [[UIView alloc]init];
    [self.view addSubview:self.bottomView];
    self.bottomView.backgroundColor = HMSThemeBackgroundColor;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icontips.mas_bottom).with.offset(15);
        make.width.mas_equalTo(@(KScreenWidth));
        make.bottom.equalTo(ws.view);
    }];
    
    self.bottomLoginView = [[UIView alloc]init];
    [self.bottomView addSubview:self.bottomLoginView];
    self.bottomLoginView.backgroundColor = [UIColor whiteColor];
    self.bottomLoginView.layer.cornerRadius = 5;
    [self.bottomLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.bottomView).with.offset(10);
        make.right.equalTo(self.bottomView).with.offset(-10);
    }];
    
    self.nikeNameTF = [UITextField textFieldWithPlaceholder:@"输入您的昵称" Font:HMSFOND(15) TextColor:[UIColor blackColor] HorderColor:[UIColor lightGrayColor] BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    [self.bottomLoginView addSubview:self.nikeNameTF];
    [self.nikeNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLoginView).with.offset(5);
        make.left.equalTo(self.bottomLoginView).with.offset(15);
        make.right.equalTo(self.bottomLoginView).with.offset(-15);
        make.height.mas_equalTo(@40);
    }];
    
    self.dividerLine = [UIView new];
    self.dividerLine.backgroundColor =UIColorFromRGB(0x8e9fa8);
    [self.bottomLoginView addSubview:self.dividerLine];
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nikeNameTF.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@0.5);
        make.left.right.equalTo(self.bottomLoginView);
    }];
    
    self.passwordTF = [UITextField textFieldWithPlaceholder:@"输入密码(至少6位)" Font:HMSFOND(15) TextColor:[UIColor blackColor] HorderColor:
                           [UIColor lightGrayColor] BottomLineColor:nil TfType:UITextAutocorrectionTypeNo];
    self.passwordTF.secureTextEntry =YES;
    [self.bottomLoginView addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dividerLine).with.offset(5);
        make.left.equalTo(self.bottomLoginView).with.offset(15);
        make.right.equalTo(self.bottomLoginView).with.offset(-15);
        make.height.mas_equalTo(@40);
    }];
    
    [self.bottomLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.passwordTF).with.offset(5);
    }];
    
    self.tipsOne = [UILabel labelWithTitle:@"密码格式错误,请重新输入" Color:UIColorFromRGB(0xfb734f) Font:HMSFOND(12) textAlignment:NSTextAlignmentCenter];
    [self.bottomView addSubview:self.tipsOne];
    self.tipsOne.hidden = YES;
    [self.tipsOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLoginView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.tipsOne.superview);
        make.height.mas_equalTo(@20);
    }];
    
    self.doneRegisterBtn = [UIButton buttonWithTitle:@"完成" font:HMSFOND(15) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(doneRegisterBtnClick:) viewController:self cornerRadius:5];
    [self.bottomView addSubview:self.doneRegisterBtn];
    [self.doneRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLoginView.mas_bottom).with.offset(40);
        make.left.equalTo(self.bottomLoginView).with.offset(15);
        make.right.equalTo(self.bottomLoginView).with.offset(-15);
        make.height.mas_equalTo(@44);
    }];
    
    if (self.pageType==HMSRegisterTwoTypeLoginFirst) {
        self.tipsTwo = [UILabel labelWithTitle:@"您的手机号属于首次登录,需要完善个人信息" Color:UIColorFromRGB(0x1976d2) Font:HMSFOND(12) textAlignment:NSTextAlignmentRight];
        [self.bottomView addSubview:self.tipsTwo];
        //self.tipsTwo.hidden = YES;
        [self.tipsTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.doneRegisterBtn.mas_bottom).with.offset(10);
            make.centerX.equalTo(self.tipsOne.superview);
            make.height.mas_equalTo(@20);
        }];
    }
}


-(void)iconBtnClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    HMSSelectIconImageTypeView *iconImgView = [[HMSSelectIconImageTypeView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [iconImgView show];
    iconImgView.selectType = ^(HMSSelectIconImageType selectType){
        if (selectType==HMSSelectIconImageTypeOne) {
            [self openCamera];
        }else
        {
            [self openAlbum];
        }
    };
}


-(void)doneRegisterBtnClick:(UIButton *)btn
{
    self.tipsOne.hidden =YES;
    if (self.nikeNameTF.text.length==0) {
        self.tipsOne.text = @"请输入昵称";
        self.tipsOne.hidden =NO;
        return;
    }
    if (![HMSUtils userPwdLengthMatch:self.passwordTF.text]) {
        self.tipsOne.text = @"密码格式错误,请重新输入";
        self.tipsOne.hidden =NO;
        return;
    }

    if (self.iconImg) {
         [SVProgressHUD show];
        [HMSNetWorkManager requestJsonDataWithPath:@"user/get-upload-token" withParams:nil withMethodType:HttpRequestTypeGet success:^(id respondObj) {
            [SVProgressHUD dismiss];
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                
                NSString *token = [[respondObj objectForKey:@"data"] objectForKey:@"token"];
                NSString *filename = [[respondObj objectForKey:@"data"] objectForKey:@"filename"];
                
                QNUploadManager *upManager = [[QNUploadManager alloc] init];
                NSData *data = UIImageJPEGRepresentation(self.iconImg,0.8);
                [upManager putData:data key:filename token:token
                          complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                              NSLog(@"七牛info%@", info);
                              NSLog(@"七牛resp%@", resp);
                              
                              self.avatar = [HMSUtils escapedString:filename];
                              
                              [self createAccount];
                              
                            } option:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    }else
    {
        [self createAccount];
    }
    
}

-(void)createAccount
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNumber;
    params[@"password"] = [HMSUtils escapedString:self.passwordTF.text];
    params[@"avatar"] = [HMSUtils escapedString:self.avatar];
    params[@"username"] = self.nikeNameTF.text;
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"user/regist-by-mobile" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            [SVProgressHUD showSuccessWithStatus:@"注册完成，请登录"];
            [HMSUtils changeRootVCtoLoginVC];
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

- (void)openAlbum
{
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    //self.pickerVC = ipc;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 * 打开照相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    //self.pickerVC = ipc;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -------------------------- UIImagePickerControllerDelegate-------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.iconBtn setImage:image forState:UIControlStateNormal];
    //  [self.icon setImage:[UIImage imageWithImage:image borderWidth:0 color:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    self.iconImg = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
        viewController.navigationItem.rightBarButtonItem.tintColor = HMSThemeColor;
        viewController.navigationController.navigationBar.tintColor = HMSThemeColor;
    }
}

@end

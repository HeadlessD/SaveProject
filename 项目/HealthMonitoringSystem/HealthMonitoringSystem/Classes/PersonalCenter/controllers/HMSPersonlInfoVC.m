//
//  HMSPersonlInfoVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/5.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSPersonlInfoVC.h"
#import "HMSPersonlInfoBtn.h"
#import "HMSSelectIconImageTypeView.h"
#import "HMSInputAccessoryView.h"
#import <UIButton+WebCache.h>
@interface HMSPersonlInfoVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) UIButton *saveBtn;

@property (nonatomic,strong) UIScrollView * BaseScrollView;

@property (nonatomic,strong) UIButton *headerImgBtn;



@property (nonatomic,strong) HMSPersonlInfoBtn *nikeNameBtn;

@property (nonatomic,strong) HMSPersonlInfoBtn *sexBtn;

@property (nonatomic,strong) HMSPersonlInfoBtn *birthdayBtn;

@property(nonatomic,strong) UIPickerView *datePickerView;

@property(nonatomic,strong) NSMutableArray *datePickerArray;

@property(nonatomic,assign) NSInteger birthdayYearSelected;
@property(nonatomic,assign) NSInteger birthdayMonthSelected;
@property(nonatomic,assign) NSInteger birthdayDaySelected;

@property(nonatomic,strong) UIGestureRecognizer *tap;
@property(nonatomic,strong) UIView *blur;

@property (nonatomic,strong) UIImage *iconImg;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *nikeName;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *birthday;

@property (nonatomic,strong) NSMutableDictionary *updataParams;
@end

@implementation HMSPersonlInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    self.saveBtn = [self setNavRightItem:@"保存" normalColor:HMSThemeColor highLTColor:nil fontSize:iPhone5_5s?16:17 size:CGSizeMake(60, 40)];
    [self.saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.saveBtn.enabled = NO;
    
     self.datePickerView = [self createPickerView];
    [self initPickerViewData];
    
    [self initView];
}

-(UIPickerView *)createPickerView{
    
    UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,KScreenHeight-150, KScreenWidth, 180)];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = NO;
    return pickerView;
}
-(void)initPickerViewData{
    //生日数据
    self.datePickerArray = [[NSMutableArray alloc]init];
    NSMutableArray *yearArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<=100; i++) {
        [yearArray addObject:[NSNumber numberWithInteger:2017 - i ]];
    }
    NSMutableArray *monthArray = [[NSMutableArray alloc]init];
    for (int i = 1; i<= 12; i++) {
        [monthArray addObject:[NSNumber numberWithInteger:i]];
    }
    NSMutableArray *dayArray = [[NSMutableArray alloc]init];
    for (int i = 1; i<= 31; i++) {
        [dayArray addObject:[NSNumber numberWithInteger:i]];
    }
    [self.datePickerArray addObject:yearArray];;
    [self.datePickerArray addObject:monthArray];
    [self.datePickerArray addObject:dayArray];
}

-(void)initView
{
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
    
    self.headerImgBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"defaul_manHeaderImg"] highLightImg:nil BGColor:nil clickAction:@selector(headerImgBtnClick:) viewController:self cornerRadius:45];
    [self.headerImgBtn sd_setImageWithURL:[NSURL URLWithString:[HMSAccount shareAccount].avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaul_manHeaderImg"]];
    self.headerImgBtn.frame = CGRectMake(0, 15, 90, 90);
    self.headerImgBtn.centerX =self.BaseScrollView.centerX;
    [self.BaseScrollView addSubview:self.headerImgBtn];
    
    UIImageView *gearImageView =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgBtn.frame)-25, CGRectGetMaxY(self.headerImgBtn.frame)-25, 25, 25)];
    gearImageView.image =[UIImage imageNamed:@"personalCenter_headerImgCamera"];
    [self.BaseScrollView addSubview:gearImageView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerImgBtn.frame)+41, self.BaseScrollView.width, 0)];
    bottomView.backgroundColor = HMSThemeBackgroundColor;
    [self.BaseScrollView addSubview:bottomView];
    
    UIView *listViewOne =[[UIView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth-24, 150)];
    listViewOne.layer.cornerRadius = 3;
    [bottomView addSubview:listViewOne];
    
    self.nikeNameBtn =[HMSPersonlInfoBtn buttonWithTitle:@"昵称" text:[HMSAccount shareAccount].username image:nil rect:CGRectMake(0, 0, listViewOne.width, 50) icon:nil cornerType:HMSPersonlInfoBtnCornerTop isLine:YES clickAction:@selector(nikeNameClick:) viewController:self];
    self.nikeNameBtn.textTitleTF.delegate =self;
    self.nikeNameBtn.textTitleTF.hidden = NO;
    
    [self.nikeNameBtn.textTitleTF addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.nikeNameBtn.textTitleTF.inputAccessoryView = [[HMSInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) text:@"请输入昵称" Block:^{
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app.window endEditing:YES];
    }];
    [listViewOne addSubview:self.nikeNameBtn];
    
    
    self.sexBtn =[HMSPersonlInfoBtn buttonWithTitle:@"性别" text:nil image:[[HMSAccount shareAccount].sex isEqualToString:@"0"]?[UIImage imageNamed:@"personalCenter_man"]:[UIImage imageNamed:@"personalCenter_woman"] rect:CGRectMake(0, 50, listViewOne.width, 50) icon:nil cornerType:HMSPersonlInfoBtnCornerNone isLine:YES clickAction:@selector(sexClick:) viewController:self];
    self.sexBtn.iconImageView.hidden = NO;
    [listViewOne addSubview:self.sexBtn];
    
    
    self.birthdayBtn =[HMSPersonlInfoBtn buttonWithTitle:@"生日" text:[HMSAccount shareAccount].birthday image:nil rect:CGRectMake(0, 100, listViewOne.width, 50) icon:nil cornerType:HMSPersonlInfoBtnCornerBottom isLine:NO clickAction:@selector(birthdayClick:) viewController:self];
    self.birthdayBtn.textTitleTF.hidden = NO;
    self.birthdayBtn.textTitleTF.delegate =self;
    self.birthdayBtn.textTitleTF.inputView = self.datePickerView;
    self.birthdayBtn.textTitleTF.inputAccessoryView = [[HMSInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) text:@"选择生日" Block:^{
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app.window endEditing:YES];
    }];
    [listViewOne addSubview:self.birthdayBtn];
    
    bottomView.height = KScreenHeight*2;
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(listViewOne.frame)+12+CGRectGetMinY(bottomView.frame))>(self.BaseScrollView.height+10)?(CGRectGetMaxY(listViewOne.frame)+12+CGRectGetMinY(bottomView.frame)):(self.BaseScrollView.height+10));
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    
    self.blur = [[UIView alloc]init];
    self.blur.backgroundColor = [UIColor blackColor];
    self.blur.frame = self.view.frame;
    self.blur.alpha = 0.0f;
    [self.blur addGestureRecognizer:self.tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.blur];
    
}


-(void)nikeNameClick:(HMSPersonlInfoBtn *)btn
{
    
}
-(void)sexClick:(HMSPersonlInfoBtn *)btn
{
    [self.view endEditing:YES];
    __block typeof(self) weakSelf = self;
    HMSSelectIconImageTypeView *iconImgView = [[HMSSelectIconImageTypeView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:@"选择性别" oneImage:[UIImage imageNamed:@"defaul_manHeaderImg"] oneText:@"男" oneTextColor:HMSThemeColor twoImage:[UIImage imageNamed:@"defaul_womanHeaderImg"] twoText:@"女" twoTextColor:UIColorFromRGB(0xfb734f)];
    [iconImgView show];
    iconImgView.selectType = ^(HMSSelectIconImageType selectType){
        if (selectType==HMSSelectIconImageTypeOne) {
            weakSelf.saveBtn.enabled =YES;
            weakSelf.sexBtn.iconImageView.image = [UIImage imageNamed:@"personalCenter_man"];
            weakSelf.sex =@"0";
        }else
        {
            weakSelf.saveBtn.enabled =YES;
            weakSelf.sexBtn.iconImageView.image = [UIImage imageNamed:@"personalCenter_woman"];
            weakSelf.sex =@"1";
        }
    };
}
-(void)birthdayClick:(HMSPersonlInfoBtn *)btn
{
    
}

-(void)headerImgBtnClick:(UIButton *)btn
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

-(void)didPressRightItem:(UIButton *)btn
{
    
    if (self.iconImg) {
        [SVProgressHUD show];
        [HMSNetWorkManager requestJsonDataWithPath:@"user/get-upload-token" withParams:nil withMethodType:HttpRequestTypeGet success:^(id respondObj) {
            
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
                              
                              [self updataUserInfo];
                              
                          } option:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    }else
    {
        [self updataUserInfo];
    }
    
    
}
         
-(void)updataUserInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = self.nikeNameBtn.textTitleTF.text;
    params[@"birthday"] = self.birthday?self.birthday:self.birthdayBtn.textTitleTF.text;
    params[@"sex"] = self.sex?self.sex:[HMSAccount shareAccount].sex;
    params[@"avatar"] = self.avatar?self.avatar:[HMSAccount shareAccount].avatar;
    params[@"avatar"] = [HMSUtils escapedString:params[@"avatar"]];
    self.updataParams = params;
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"user/update-user-info" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            HMSAccount *account =[HMSAccount shareAccount];
            
            account.username =self.updataParams[@"username"];
            account.birthday =self.updataParams[@"birthday"];
            account.sex =self.updataParams[@"sex"];
            account.avatar =self.updataParams[@"avatar"];
            [account getUserInfoSuccess:^{
                [account save];
            } failure:^(NSString *error) {
                [SVProgressHUD showErrorWithStatus:error];
            }];
            
            [SVProgressHUD showSuccessWithStatus:@"修改信息成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if (self.dissmissVC) {
                    self.dissmissVC();
                }
            });
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}
         
         
#pragma mark -------------------------- UIImagePickerControllerDelegate-------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.saveBtn.enabled =YES;
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.headerImgBtn setImage:image forState:UIControlStateNormal];
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


#pragma mark ------------------------- UIPickerDelegate------------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.datePickerArray.count;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.datePickerArray[component] count];
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50.0f;
}
//返回指定列的宽度
//- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    if (self.pickerArray.count==3) {
//        return KScreenWidth/3;
//    }else{
//        return KScreenWidth/2;
//    }
//}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    UILabel *textL = (UILabel *)view;
    if (!textL) {
        textL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,40, 50)];
    }
    //UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,40, 50)];
    textL.backgroundColor = [UIColor clearColor];
    textL.textAlignment = NSTextAlignmentCenter;
    textL.textColor = [UIColor grayColor];
    textL.font = [UIFont systemFontOfSize:20];
    //textL.text =self.pickerArray[component][row];
    
    textL.frame = CGRectMake(0, 0, KScreenWidth/3, 50);
    textL.text = [NSString stringWithFormat:@"%@",self.datePickerArray[component][row]];
    return textL;
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel* label = (UILabel*)[pickerView viewForRow:row forComponent:component];
    label.textColor = HMSThemeColor;
    label.font = [UIFont boldSystemFontOfSize:30];
    NSString *yearStr,*monthStr,*dayStr;
    
    if (component == 0) {
        yearStr = self.datePickerArray[0][row];
        monthStr = self.datePickerArray[1][self.birthdayMonthSelected];
        dayStr = self.datePickerArray[2][self.birthdayDaySelected];
        self.birthdayYearSelected = row;
    }else if (component == 1){
        yearStr = self.datePickerArray[0][self.birthdayYearSelected];
        monthStr = self.datePickerArray[1][row];
        dayStr = self.datePickerArray[2][self.birthdayDaySelected];
        self.birthdayMonthSelected = row;
    }else{
        yearStr = self.datePickerArray[0][self.birthdayYearSelected];
        monthStr = self.datePickerArray[1][self.birthdayMonthSelected];
        dayStr = self.datePickerArray[2][row];
        self.birthdayDaySelected = row;
    }
    
    self.saveBtn.enabled =YES;
    self.birthdayBtn.textTitleTF.text = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
    self.birthday =self.birthdayBtn.textTitleTF.text;
}


//注意：事件类型是：`UIControlEventEditingChanged`
-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
    self.saveBtn.enabled =YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.blur.alpha = 0.7;
    }];
    
    if (textField ==self.birthdayBtn.textTitleTF) {
        [self.datePickerView selectRow:37 inComponent:0 animated:YES];
    }
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

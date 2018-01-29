//
//  HMSAddOldManVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSAddOldManVC.h"
#import "HMSSelectIconImageTypeView.h"
#import "HMSOldManPropertyCell.h"
#import "HMSInputAccessoryView.h"
#import "HMSOldManModel.h"

@interface HMSAddOldManVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIScrollView *BaseScrollView;

@property (nonatomic,strong) UIButton *headerImgBtn;

@property (nonatomic,strong) UIImage * iconImg;

@property (nonatomic,strong) NSString * avatar;

@property (nonatomic,strong) NSString * sex;

@property (nonatomic,strong) UIButton *doneRegisterBtn;

@property (nonatomic,strong) HMSSelectIconImageTypeView *sexIconImgView;

@property(nonatomic,strong) UIGestureRecognizer *tap;
@property(nonatomic,strong) UIView *blur;

@property(nonatomic,strong) HMSOldManPropertyCell *nikeNameCell;

@property(nonatomic,strong) HMSOldManPropertyCell *birthdayCell;
@property(nonatomic,strong) UIPickerView *datePickerView;

@property(nonatomic,strong) NSMutableArray *datePickerArray;

@property(nonatomic,assign) NSInteger birthdayYearSelected;
@property(nonatomic,assign) NSInteger birthdayMonthSelected;
@property(nonatomic,assign) NSInteger birthdayDaySelected;

@property(nonatomic,strong) HMSOldManPropertyCell *sexCell;

@property(nonatomic,strong) HMSOldManPropertyCell *roleCell;

@property(nonatomic,strong) HMSOldManPropertyCell *phoneNumCell;

@property(nonatomic,strong) HMSOldManPropertyCell *deviceNumCell;

@property(nonatomic,strong) HMSOldManPropertyCell *medicalHistoryNumCell;
@end

@implementation HMSAddOldManVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新建老人";
    
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
    WS(ws);
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
    
    self.headerImgBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"defaul_manHeaderImg"] highLightImg:nil BGColor:nil clickAction:@selector(headerImgBtnClick:) viewController:self cornerRadius:45];
    [self.headerImgBtn setImage:[UIImage imageNamed:@"defaul_oldManHeaderImg"] forState:UIControlStateNormal];
    self.headerImgBtn.frame = CGRectMake(0, 15, 90, 90);
    self.headerImgBtn.centerX =self.BaseScrollView.centerX;
    [self.BaseScrollView addSubview:self.headerImgBtn];
    
    UIImageView *gearImageView =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgBtn.frame)-25, CGRectGetMaxY(self.headerImgBtn.frame)-25, 25, 25)];
    gearImageView.image =[UIImage imageNamed:@"personalCenter_headerImgCamera"];
    [self.BaseScrollView addSubview:gearImageView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerImgBtn.frame)+41, self.BaseScrollView.width, KScreenHeight *2)];
    bottomView.backgroundColor = HMSThemeBackgroundColor;
    [self.BaseScrollView addSubview:bottomView];
    
    
    UIView *listViewOne =[[UIView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth-24, 150)];
    listViewOne.layer.cornerRadius = 3;
    [bottomView addSubview:listViewOne];
    
    self.nikeNameCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, 0, listViewOne.width, 50) WithTitle:@"昵称" text:nil Placeholder:@"输入昵称" rightImg:[UIImage imageNamed:@"oldman_star"] cornerType:HMSOldManPropertyCellCornerTop isLine:YES];
    self.nikeNameCell.textTitleTF.inputAccessoryView = [[HMSInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) text:@"请输入昵称" Block:^{
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app.window endEditing:YES];
    }];
    [self.nikeNameCell.textTitleTF addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.nikeNameCell.textTitleTF.delegate = self;
    [listViewOne addSubview:self.nikeNameCell];
    
    
    self.sexCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nikeNameCell.frame), listViewOne.width, 50) WithTitle:@"性别" text:nil Placeholder:nil rightImg:[UIImage imageNamed:@"oldman_star"] cornerType:HMSOldManPropertyCellCornerNone isLine:YES];
    self.sexIconImgView = [[HMSSelectIconImageTypeView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:@"选择性别" oneImage:[UIImage imageNamed:@"defaul_manHeaderImg"] oneText:@"男" oneTextColor:HMSThemeColor twoImage:[UIImage imageNamed:@"defaul_womanHeaderImg"] twoText:@"女" twoTextColor:UIColorFromRGB(0xfb734f)];
    self.sexCell.textTitleTF.inputView =self.sexIconImgView.sliderBGView;
    __block typeof(self.sexCell)weakSexCell =self.sexCell;
    self.sexIconImgView.selectTypeNoneAction = ^(HMSSelectIconImageType selectType){
        if (selectType==HMSSelectIconImageTypeOne) {
            weakSexCell.textTitleTF.text = @"男";
            ws.sex = @"0";
        }else
        {
            weakSexCell.textTitleTF.text = @"女";
            ws.sex = @"1";
        }
        [UIView animateWithDuration:0.15 animations:^{
            [ws.view endEditing:YES];
        }];
    };
    self.sexCell.textTitleTF.delegate = self;
    [listViewOne addSubview:self.sexCell];
    
    
    
    self.birthdayCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sexCell.frame), listViewOne.width, 50) WithTitle:@"生日" text:nil Placeholder:nil rightImg:[UIImage imageNamed:@"oldman_star"] cornerType:HMSOldManPropertyCellCornerNone isLine:YES];
    self.birthdayCell.textTitleTF.delegate = self;
    self.birthdayCell.textTitleTF.inputView = self.datePickerView;
    self.birthdayCell.textTitleTF.inputAccessoryView = [[HMSInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) text:@"选择生日" Block:^{
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app.window endEditing:YES];
    }];
    [listViewOne addSubview:self.birthdayCell];
    
    
    self.roleCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.birthdayCell.frame), listViewOne.width, 50) WithTitle:@"角色" text:nil Placeholder:@"老爸 老妈 爷爷 奶奶 舅舅" rightImg:nil cornerType:HMSOldManPropertyCellCornerNone isLine:YES];
    self.roleCell.textTitleTF.delegate = self;
    [listViewOne addSubview:self.roleCell];
    
    self.phoneNumCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roleCell.frame), listViewOne.width, 50) WithTitle:@"手机号码" text:nil Placeholder:@"输入手机号码" rightImg:[UIImage imageNamed:@"oldman_star"] cornerType:HMSOldManPropertyCellCornerNone isLine:YES];
    self.phoneNumCell.textTitleTF.delegate = self;
    self.phoneNumCell.textTitleTF.keyboardType = UIKeyboardTypePhonePad;
    [listViewOne addSubview:self.phoneNumCell];
    
//    self.deviceNumCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumCell.frame), listViewOne.width, 50) WithTitle:@"设备号码" text:nil Placeholder:@"设备号由养老院提供" rightImg:nil cornerType:HMSOldManPropertyCellCornerBottom isLine:YES];
//    self.deviceNumCell.textTitleTF.delegate = self;
//    [listViewOne addSubview:self.deviceNumCell];
    
    self.medicalHistoryNumCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumCell.frame), listViewOne.width, 50) WithTitle:@"病史" text:nil Placeholder:@"高血压 心脏病 糖尿病" rightImg:nil cornerType:HMSOldManPropertyCellCornerTop isLine:NO];
    self.medicalHistoryNumCell.textTitleTF.delegate = self;
    [listViewOne addSubview:self.medicalHistoryNumCell];
    
    listViewOne.height = CGRectGetMaxY(self.medicalHistoryNumCell.frame);
    
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(listViewOne.frame)+12+CGRectGetMinY(bottomView.frame)+74)>(self.BaseScrollView.height+10)?(CGRectGetMaxY(listViewOne.frame)+12+CGRectGetMinY(bottomView.frame)+74):(self.BaseScrollView.height+10));
    
    self.doneRegisterBtn = [UIButton buttonWithTitle:@"完成" font:HMSFOND(16) TitleColor:[UIColor whiteColor] BGColor:UIColorFromRGB(0x1976d2) clickAction:@selector(doneRegisterBtnClick:) viewController:self cornerRadius:5];
    
    self.doneRegisterBtn.frame = CGRectMake(listViewOne.x+15, KScreenHeight-64-44-15, listViewOne.width-30, 44);
    [self.view addSubview:self.doneRegisterBtn];
    
    
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    
    self.blur = [[UIView alloc]init];
    self.blur.backgroundColor = [UIColor blackColor];
    self.blur.frame = self.view.frame;
    self.blur.alpha = 0.0f;
    [self.blur addGestureRecognizer:self.tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.blur];

}

-(void)setOldMan:(HMSOldManModel *)oldMan
{
    _oldMan = oldMan;
    self.nikeNameCell.textTitleTF.text= oldMan.name;
    self.sexCell.textTitleTF.text =[oldMan.sex isEqualToString:@"0"]?@"男":@"女";
    self.birthdayCell.textTitleTF.text =oldMan.birthday;
    self.phoneNumCell.textTitleTF.text =oldMan.mobile;
    self.medicalHistoryNumCell.textTitleTF.text =oldMan.disease_history;
}

-(void)doneRegisterBtnClick:(UIButton *)btn
{
    if (self.nikeNameCell.textTitleTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    if (self.sexCell.textTitleTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
    }
    if (self.birthdayCell.textTitleTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择生日"];
        return;
    }
    if (![HMSUtils userNameIsPhone:self.phoneNumCell.textTitleTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式错误,请重新输入"];
        return;
    }
    
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
                              
                              [self createOldMan];
                              
                          } option:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    }else
    {
        [self createOldMan];
    }
    
}

-(void)createOldMan{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"name"] = self.nikeNameCell.textTitleTF.text;
    params[@"mobile"] = self.phoneNumCell.textTitleTF.text;
    params[@"avatar"] = [HMSUtils escapedString:self.avatar];
    params[@"sex"] = self.sex;
    params[@"birthday"] = self.birthdayCell.textTitleTF.text;
    params[@"disease_history"] = self.medicalHistoryNumCell.textTitleTF.text;
    params[@"role"] = self.roleCell.textTitleTF.text;
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"member/create-member" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            [SVProgressHUD showSuccessWithStatus:@"新建老人成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if (self.controllerDismiss) {
                    self.controllerDismiss();
                }
//                if (self.dissmissVC) {
//                    self.dissmissVC();
//                }
            });
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
    

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



#pragma mark -------------------------- UIImagePickerControllerDelegate-------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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
    
    self.birthdayCell.textTitleTF.text = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
//    self.birthday =self.birthdayBtn.textTitleTF.text;
}







-(void)passConTextChange:(UITextField *)textField{
   
    if (textField == self.nikeNameCell.textTitleTF ||textField == self.roleCell.textTitleTF) {
        if (textField.text.length > 10) {
            UITextRange *markedRange = [textField markedTextRange];
            if (markedRange) {
                return;
            }
            //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
            //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
            NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:10];
            textField.text = [textField.text substringToIndex:range.location];
        }
    }else if (textField == self.medicalHistoryNumCell.textTitleTF)
    {
        if (textField.text.length > 50) {
            UITextRange *markedRange = [textField markedTextRange];
            if (markedRange) {
                return;
            }
            //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
            //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
            NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:50];
            textField.text = [textField.text substringToIndex:range.location];
        }
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.blur.alpha = 0.7;
    }];
    
    
    if (textField ==self.birthdayCell.textTitleTF) {
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

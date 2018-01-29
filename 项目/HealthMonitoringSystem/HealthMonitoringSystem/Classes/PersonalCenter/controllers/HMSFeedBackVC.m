//
//  HMSFeedBackVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSFeedBackVC.h"
#import "HMSOldManPropertyCell.h"
#import "HMSTipsView.h"

@interface HMSFeedBackVC ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIButton *saveBtn;

@property (nonatomic,strong) UIScrollView * BaseScrollView;

@property(nonatomic,strong) UITextView *feedbackTextView;
@property(nonatomic,strong) UILabel *feedbackPlaceholderLabel;

@property(nonatomic,strong) HMSOldManPropertyCell *connectCell;

@property(nonatomic,strong) UIGestureRecognizer *tap;
@property(nonatomic,strong) UIView *blur;

@property(nonatomic,strong) UILabel *stringLenthLabel;

@property(nonatomic,strong) HMSTipsView *feedbackSuccessView;
@end

@implementation HMSFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    self.view.backgroundColor = HMSThemeBackgroundColor;
    
    self.saveBtn = [self setNavRightItem:@"发送" normalColor:HMSThemeColor highLTColor:nil fontSize:iPhone5_5s?16:17 size:CGSizeMake(60, 40)];
    [self.saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.saveBtn.enabled = NO;
    
    [self initView];
}

-(void)initView
{
    
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
    
    UIView *feedTextBGView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth-24, 250)];
    feedTextBGView.backgroundColor =[UIColor whiteColor];
    [self.BaseScrollView addSubview:feedTextBGView];
    
    self.stringLenthLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentRight];
    self.stringLenthLabel.frame = CGRectMake(feedTextBGView.width-15-150, feedTextBGView.height-15, 150, 15);
    [feedTextBGView addSubview:self.stringLenthLabel];
    
    self.feedbackTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 15, feedTextBGView.width-30, feedTextBGView.height-30)];
    self.feedbackTextView.backgroundColor = [UIColor whiteColor];
    self.feedbackTextView.font = [UIFont systemFontOfSize:15];
    self.feedbackTextView.delegate = self;
    self.feedbackTextView.textColor = HMSThemeColor;
    //    [self.suggestionTextView setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.feedbackTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.feedbackPlaceholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, self.feedbackTextView.width-4, 35)];
    self.feedbackPlaceholderLabel.numberOfLines = 0;
    self.feedbackPlaceholderLabel.text = @"请简要描述您的问题和意见";
    self.feedbackPlaceholderLabel.textColor = [UIColor lightGrayColor];
    [feedTextBGView addSubview:self.feedbackTextView];
    [self.feedbackTextView addSubview:self.feedbackPlaceholderLabel];
    
    self.connectCell = [[HMSOldManPropertyCell alloc]initWithFrame:CGRectMake(feedTextBGView.x, CGRectGetMaxY(feedTextBGView.frame)+12, feedTextBGView.width, 50) WithTitle:@"联系方式" text:nil Placeholder:@"手机号码或QQ号" rightImg:nil cornerType:HMSOldManPropertyCellCornerNone isLine:NO];
    [self.connectCell.textTitleTF addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.connectCell.textTitleTF.delegate = self;
    self.connectCell.textTitleTF.keyboardType = UIKeyboardTypePhonePad;
    self.connectCell.layer.cornerRadius = 3;
    [self.BaseScrollView addSubview:self.connectCell];
    
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(self.connectCell.frame)+12)>(self.BaseScrollView.height+10)?(CGRectGetMaxY(self.connectCell.frame)+12):(self.BaseScrollView.height+10));
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    
    self.blur = [[UIView alloc]init];
    self.blur.backgroundColor = [UIColor blackColor];
    self.blur.frame = self.view.frame;
    self.blur.alpha = 0.0f;
    [self.blur addGestureRecognizer:self.tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.blur];
}



//发送按钮点击
-(void)didPressRightItem:(UIButton *)btn
{
    if (self.feedbackTextView.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的问题和意见"];
        return;
    }
    if (![HMSUtils checkQQNumber:self.connectCell.textTitleTF.text]&&![HMSUtils userNameIsPhone:self.connectCell.textTitleTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的联系方式"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"content"] = self.feedbackTextView.text;
    params[@"mobile"] = self.connectCell.textTitleTF.text;
    
    [SVProgressHUD show];
    WS(ws);
    [HMSNetWorkManager requestJsonDataWithPath:@"user/feedback" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
           
            ws.feedbackSuccessView =  [[HMSTipsView alloc]initWithTitle:@"意见反馈成功" icon:[UIImage imageNamed:@"feedback_success"]];
            ws.feedbackSuccessView.alpha = 0;
            [ws.feedbackSuccessView showInView:[UIApplication sharedApplication].keyWindow];
            
            [UIView animateWithDuration:1.0 animations:^{
                ws.feedbackSuccessView.alpha = 1;
                
            }completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ws.feedbackSuccessView removeFromSuperview];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}


#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView == self.feedbackTextView) {
        if ([textView.text isEqualToString:@""]) {
            self.feedbackPlaceholderLabel.text = @"请简要描述您的问题和意见";
        }else{
            self.feedbackPlaceholderLabel.text = @"";
        }
        
        if (self.connectCell.textTitleTF.text.length>0||self.feedbackTextView.text.length>0) {
            self.saveBtn.enabled =YES;
        }else
        {
            self.saveBtn.enabled =NO;
        }
       
        if (textView.text.length >= 200) {
            
            textView.text = [textView.text substringToIndex:200];
//            self.stringLenthLabel.text = @"200/200";
        }
        if (textView.text.length > 0) {
            self.stringLenthLabel.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
        }else
        {
            self.stringLenthLabel.text =@"";
        }
        
        
    }else{
        
    }
    
}


-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
    if (self.connectCell.textTitleTF.text.length>0||self.feedbackTextView.text.length>0) {
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

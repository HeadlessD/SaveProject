//
//  HMSInviteFriendVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/13.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSInviteFriendVC.h"
#import <MessageUI/MessageUI.h>

@interface HMSInviteFriendVC ()<MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIScrollView *BaseScrollView;

@property (nonatomic,strong) UILabel *inviteCodeLabel;

@property (nonatomic,strong) NSString *inviteCode;
@end

@implementation HMSInviteFriendVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请亲友";
    self.view.backgroundColor = HMSThemeBackgroundColor;
    
    [self initView];
    
    [self getData];
}


-(void)initView
{
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
    
    UIImageView *inviteCodeBGView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 290*HMS_ScreenScale, 180*HMS_ScreenScale)];
    inviteCodeBGView.centerX = KScreenWidth *0.5;
    inviteCodeBGView.image =[UIImage imageNamed:@"inviteCodeCar_bg"];
    [self.BaseScrollView addSubview:inviteCodeBGView];
    
    UIFont *titleFont = iPhone5_5s?HMSFOND(15):HMSFOND(16);
    UIFont *textFont = iPhone5_5s?HMSFOND(14):HMSFOND(15);
    
    CGSize labelSize =  [@"邀请码" boundingRectWithSize:CGSizeMake(KScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:0].size;
    UILabel *inviteCodeTitle = [UILabel labelWithTitle:@"邀请码" Color:[UIColor whiteColor] Font:titleFont textAlignment:NSTextAlignmentLeft];
    inviteCodeTitle.frame = CGRectMake(inviteCodeBGView.x+30, inviteCodeBGView.y+30, labelSize.width,labelSize.height);
    [self.BaseScrollView addSubview:inviteCodeTitle];
    
    self.inviteCodeLabel = [UILabel labelWithTitle:@"" Color:[UIColor whiteColor] Font:textFont textAlignment:NSTextAlignmentLeft];
    self.inviteCodeLabel.frame = CGRectMake(CGRectGetMaxX(inviteCodeTitle.frame)+30, inviteCodeTitle.y, inviteCodeBGView.width-(CGRectGetMaxX(inviteCodeTitle.frame)+30-inviteCodeBGView.x)-20, labelSize.height);
    [self.BaseScrollView addSubview:self.inviteCodeLabel];
    
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(inviteCodeBGView.frame)+12)>(self.BaseScrollView.height+10)?(CGRectGetMaxY(inviteCodeBGView.frame)+12):(self.BaseScrollView.height+10));
    
    UIButton *smsInvite = [UIButton buttonWithTitle:@"短信邀请" font:HMSFOND(17) TitleColor:[UIColor whiteColor] BGColor:nil clickAction:@selector(smsInviteClick:) viewController:self cornerRadius:0];
    [smsInvite setBackgroundImage:[UIImage imageNamed:@"blueBtnBG"] forState:UIControlStateNormal];
    [smsInvite setBackgroundImage:[UIImage imageNamed:@"blueBtnBG_select"] forState:UIControlStateHighlighted];
    smsInvite.frame = CGRectMake(20, KScreenHeight -64 -12-50, KScreenWidth -40, 50);
    [self.view addSubview:smsInvite];
    
    UIButton *wechatInvite = [UIButton buttonWithTitle:@"微信邀请" font:HMSFOND(17) TitleColor:[UIColor whiteColor] BGColor:nil clickAction:@selector(wechatInviteClick:) viewController:self cornerRadius:0];
    [wechatInvite setBackgroundImage:[UIImage imageNamed:@"blueBtnBG"] forState:UIControlStateNormal];
    [wechatInvite setBackgroundImage:[UIImage imageNamed:@"blueBtnBG_select"] forState:UIControlStateHighlighted];
    wechatInvite.frame = CGRectMake(20, smsInvite.y-12-50, smsInvite.width, 50);
    [self.view addSubview:wechatInvite];
}

-(void)getData
{
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"member_id"] = self.oldManID;
    [HMSNetWorkManager requestJsonDataWithPath:@"member/get-invitation-code" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            NSString *inviteCode =[NSString stringWithFormat:@"%@",respondObj[@"data"][@"invitation_code"]];
            self.inviteCode = inviteCode;
            if (inviteCode) {
                NSArray *codeArray = @[[inviteCode substringWithRange:NSMakeRange(0, 4)],[inviteCode substringWithRange:NSMakeRange(4, 4)],[inviteCode substringWithRange:NSMakeRange(8, 2)]];
                self.inviteCodeLabel.text =[codeArray componentsJoinedByString:@" "];
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

-(void)sendMessage:(NSString *)message withPhoneNum:(NSString *)phoneNum
{
    //实例化MFMessageComposeViewController,并设置委托
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    
    messageController.messageComposeDelegate = self;
    
    //    //拼接并设置短信内容
    //    NSString *messageContent = [NSString stringWithFormat:@"发送短信测试"];
    
    messageController.body = message;
    
    //设置发送给谁
    if (phoneNum) {
         messageController.recipients = @[phoneNum];
    }
   
    
    //推到发送试图控制器
    [self presentViewController:messageController animated:YES completion:^{
        
    }];
    
}


-(void)smsInviteClick:(UIButton *)btn
{
    [self sendMessage:self.inviteCode withPhoneNum:nil];
}

-(void)wechatInviteClick:(UIButton *)btn
{
    
}



//发送短信后回调的方法
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    [controller dismissViewControllerAnimated:YES completion:^{
        NSString *tipContent;
        switch (result) {
            case MessageComposeResultCancelled:
                tipContent = @"发送短信已取消";
                break;
                
            case MessageComposeResultFailed:
                tipContent = @"发送短信失败";
                break;
                
            case MessageComposeResultSent:
                tipContent = @"发送成功";
                break;
                
            default:
                break;
        }
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:tipContent delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alterView show];
    }];
    
    
}
@end

//
//  HMSAboutVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSAboutVC.h"
#import "HMSUpDateAppTool.h"
@interface HMSAboutVC ()
@property (nonatomic,strong)UILabel *topLabel;

@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)UIImageView *aboutBgView;

@property (nonatomic,strong)UIImageView *aboutIconImgView;

@property (nonatomic,strong)UILabel *versionLabel;

@property (nonatomic,strong)UIButton *nVersinCheckBtn;

@property (nonatomic,strong) UIScrollView * BaseScrollView;


@end

@implementation HMSAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HMSThemeBackgroundColor;
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)initView
{
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.topLabel =[UILabel labelWithTitle:@"关于" Color:HMSThemeColor Font:iPhone5_5s?HMSFOND(18):HMSFOND(19) textAlignment:NSTextAlignmentCenter] ;
    self.topLabel.frame =CGRectMake(70, 20, KScreenWidth-140, 44);
    [self.view addSubview:self.topLabel];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setFrame:CGRectMake(8, 17, 50, 50)];
    [self.backBtn setImage:[[UIImage imageNamed:@"navigationBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
    
    
    self.aboutBgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth-24, (KScreenWidth-24)*1.1)];
    self.aboutBgView.image =[UIImage imageNamed:@"about_versionBg"];
    [self.BaseScrollView addSubview:self.aboutBgView];
    
    self.aboutIconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.aboutBgView.centerY -120, 120, 120)];
    self.aboutIconImgView.layer.cornerRadius = 20;
    self.aboutIconImgView.clipsToBounds =YES;
    self.aboutIconImgView.backgroundColor =[UIColor whiteColor];
    self.aboutIconImgView.image =[UIImage imageNamed:@""];
    self.aboutIconImgView.centerX = self.aboutBgView.centerX;
    [self.BaseScrollView addSubview:self.aboutIconImgView];
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.versionLabel = [UILabel labelWithTitle:[NSString stringWithFormat:@"xxx V %@",app_Version] Color:[UIColor whiteColor] Font:HMSFOND(16) textAlignment:NSTextAlignmentCenter];
    self.versionLabel.frame = CGRectMake(self.aboutBgView.x, CGRectGetMaxY(self.aboutIconImgView.frame)+25, self.aboutBgView.width, 20);
    [self.BaseScrollView addSubview:self.versionLabel];
    
    
    self.nVersinCheckBtn = [self buttonWithTitle:@"新版本检测" rect:CGRectMake(12, CGRectGetMaxY(self.aboutBgView.frame)+12, self.aboutBgView.width, 50) icon:nil isLine:NO clickAction:@selector(nVersinCheckBtnClick:) viewController:self];
    self.nVersinCheckBtn.layer.cornerRadius =3;
    self.nVersinCheckBtn.clipsToBounds = YES;
    [self.BaseScrollView addSubview:self.nVersinCheckBtn];
    
    
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(self.nVersinCheckBtn.frame)+12)>(self.BaseScrollView.height+10)?(CGRectGetMaxY(self.nVersinCheckBtn.frame)+12):(self.BaseScrollView.height+10));
}



-(void)nVersinCheckBtnClick:(UIButton *)btn
{
    [SVProgressHUD show];
    [HMSUpDateAppTool hs_updateWithAPPID:@"1227399619" error:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
    } block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        
        if (isUpdate) {
            [SVProgressHUD dismiss];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新？",storeVersion] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
            alert.tag = 2000;
            [alert show];
        }else
        {
            [SVProgressHUD showInfoWithStatus:@"当前为最新版本"];
        }
    }];
    
}

-(void)backBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ---生产定制按钮工厂方法
-(UIButton *)buttonWithTitle:(NSString *)title rect:(CGRect )rect icon:(NSString *)icon isLine:(BOOL)isline clickAction:(SEL)clickAction viewController:(id)viewController
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =rect;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:HMSCustomColor(190, 190, 190)] forState:UIControlStateHighlighted];
    
    
    
    UILabel *titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 20)];
    titleLabel.font =HMSFOND(17);
    titleLabel.textAlignment =NSTextAlignmentLeft;
    titleLabel.textColor =[UIColor blackColor];
    titleLabel.centerY =btn.height*0.5;
    titleLabel.text =title;
    titleLabel.size = [title boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(17)} context:0].size;
    [btn addSubview:titleLabel];
    
    [btn addTarget:viewController action:clickAction forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arraw =[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-7-20, 0, 7, 15)];
    arraw.image =[UIImage imageNamed:@"personalCenter_garyArrow"];
    arraw.centerY =btn.height *0.5;
    [btn addSubview:arraw];
    
    if(isline){
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, btn.height-1, btn.width, 1)];
        line.backgroundColor =HMSThemeBackgroundColor;
        line.alpha =1;
        [btn addSubview:line];
        
        
    }
    
    
    return  btn;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 2000)
    {
        if (buttonIndex == 0)
        {
            
        }
        else if(buttonIndex == 1)
        {
            NSString* url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",@"1227399619"];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:url]];
        }
    }
}
@end

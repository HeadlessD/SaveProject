//
//  HMSHMSPersonalCenterVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHMSPersonalCenterVC.h"
#import "HMSPersonlInfoVC.h"
#import <UIButton+WebCache.h>
#import "HMSMyOldManVC.h"
#import "HMSAccountInfoVC.h"
#import "HMSAboutVC.h"
#import "HMSFeedBackVC.h"
#import "HMSTipsView.h"
#import "HMSSharePopView.h"


@interface HMSHMSPersonalCenterVC ()

@property (nonatomic,strong) UIScrollView * BaseScrollView;

@property (nonatomic,strong) UIButton *headerImgBtn;

@property (nonatomic,strong) UILabel *headerTitleLabel;

@property (nonatomic,strong) HMSTipsView *clearCacheSucessView;
@end

@implementation HMSHMSPersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavRightItem:@"退出登录" normalColor:UIColorFromRGB(0xfb734f) highLTColor:nil fontSize:iPhone5_5s?16:17 size:CGSizeMake(80, 40)];
    [self initView];
    
}

-(void)initView
{
    //WS(ws);
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
    
    
    self.headerImgBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"defaul_manHeaderImg"] highLightImg:nil BGColor:nil clickAction:@selector(headerImgBtnClick:) viewController:self cornerRadius:45];
    self.headerImgBtn.backgroundColor =[UIColor redColor];
    [self.headerImgBtn sd_setImageWithURL:[NSURL URLWithString:[HMSAccount shareAccount].avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaul_manHeaderImg"]];
    self.headerImgBtn.frame = CGRectMake(0, 25, 90, 90);
    self.headerImgBtn.centerX =self.BaseScrollView.centerX;
    [self.BaseScrollView addSubview:self.headerImgBtn];
    
    UIImageView *gearImageView =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgBtn.frame)-25, CGRectGetMaxY(self.headerImgBtn.frame)-25, 25, 25)];
    gearImageView.image =[UIImage imageNamed:@"personalCenter_headerImgGaer"];
    [self.BaseScrollView addSubview:gearImageView];
    
    UIView *arrawBaseView = [[UIView alloc]initWithFrame:CGRectMake(self.BaseScrollView.width-18-32, 0, 30, 20)];
    arrawBaseView.centerY =self.headerImgBtn.centerY;
    [self.BaseScrollView addSubview:arrawBaseView];
    UIImageView *arraw =[[UIImageView alloc]initWithFrame:CGRectMake(arrawBaseView.width-7-12, 0, 7, 15)];
    arraw.image =[UIImage imageNamed:@"personalCenter_garyArrow"];
    arraw.centerY =arrawBaseView.height*0.5;
    [arrawBaseView addSubview:arraw];
    
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goPersonlInfoPage)];
    [arrawBaseView addGestureRecognizer:PrivateLetterTap];
    
    self.headerTitleLabel = [UILabel labelWithTitle:[HMSAccount shareAccount].username Color:[UIColor blackColor] Font:HMSFOND(17) textAlignment:NSTextAlignmentCenter];
    self.headerTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headerImgBtn.frame)+10, self.BaseScrollView.width, 20);
    [self.BaseScrollView addSubview:self.headerTitleLabel];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerImgBtn.frame)+56, self.BaseScrollView.width, 0)];
    bottomView.backgroundColor = HMSThemeBackgroundColor;
    [self.BaseScrollView addSubview:bottomView];
    
    UIView *listViewOne =[[UIView alloc]initWithFrame:CGRectMake(12, 12, KScreenWidth-24, 100)];
    listViewOne.layer.cornerRadius = 3;
    [bottomView addSubview:listViewOne];
    
    UIButton *myOldMan =[self buttonWithTitle:@"我的老人" rect:CGRectMake(0, 0, listViewOne.width, 50) icon:nil isLine:YES btnPushType:HMSPersonalCenterVCPushBtnTypeMyOldMan];
    [listViewOne addSubview:myOldMan];
    
    UIButton *accountInfo =[self buttonWithTitle:@"账号信息" rect:CGRectMake(0, 50, listViewOne.width, 50) icon:nil isLine:NO btnPushType:HMSPersonalCenterVCPushBtnTypeAccountInfo];
    [listViewOne addSubview:accountInfo];
    
    UIButton *recommendToFriendBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"personalCenter_sharePic"] highLightImg:nil BGColor:[UIColor orangeColor] clickAction:@selector(recommendToFriendBtnClick:) viewController:self cornerRadius:3];
    recommendToFriendBtn.frame = CGRectMake(12, CGRectGetMaxY(listViewOne.frame)+12, listViewOne.width, 100);
    [bottomView addSubview:recommendToFriendBtn];
    
    UIImageView *writeArraw =[[UIImageView alloc]initWithFrame:CGRectMake(recommendToFriendBtn.width-7-10, 0, 7, 15)];
    writeArraw.image =[UIImage imageNamed:@"personalCenter_writeArrow"];
    writeArraw.centerY =recommendToFriendBtn.height *0.5;
    [recommendToFriendBtn addSubview:writeArraw];
    
    UIView *listViewTwo =[[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(recommendToFriendBtn.frame)+12, KScreenWidth-24, 150)];
    listViewTwo.layer.cornerRadius = 3;
    [bottomView addSubview:listViewTwo];
    
    UIButton *about =[self buttonWithTitle:@"关于我们" rect:CGRectMake(0, 0, listViewOne.width, 50) icon:nil isLine:YES btnPushType:HMSPersonalCenterVCPushBtnTypeAbout];
    [listViewTwo addSubview:about];
    
    UIButton *feedBack =[self buttonWithTitle:@"意见反馈" rect:CGRectMake(0, 50, listViewOne.width, 50) icon:nil isLine:YES btnPushType:HMSPersonalCenterVCPushBtnTypeFeedBack];
    [listViewTwo addSubview:feedBack];
    
    UIButton *clearCache =[self buttonWithTitle:@"清除缓存" rect:CGRectMake(0, 100, listViewOne.width, 50) icon:nil isLine:NO btnPushType:HMSPersonalCenterVCPushBtnTypeClearCache];
    [listViewTwo addSubview:clearCache];
    
    bottomView.height = KScreenHeight*2;
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(listViewTwo.frame)+12+CGRectGetMinY(bottomView.frame))>(self.BaseScrollView.height+10)?(CGRectGetMaxY(listViewTwo.frame)+12+CGRectGetMinY(bottomView.frame)):(self.BaseScrollView.height+10));
    
    

}

-(void)headerImgBtnClick:(UIButton *)btn
{
    [self goPersonlInfoPage];
}



-(void)pushBtnAction:(UIButton *)btn
{
    switch (btn.tag) {
        case HMSPersonalCenterVCPushBtnTypeMyOldMan:
        {
            HMSMyOldManVC *oldManVC = [[HMSMyOldManVC alloc]init];
            [self.navigationController pushViewController:oldManVC animated:YES];
        }
            break;
        case HMSPersonalCenterVCPushBtnTypeAccountInfo:
        {
            HMSAccountInfoVC *accountInfoVC =[[HMSAccountInfoVC alloc]init];
            [self.navigationController pushViewController:accountInfoVC animated:YES];
        }
            break;
        case HMSPersonalCenterVCPushBtnTypeAbout:
        {
            HMSAboutVC *aboutVC =[[HMSAboutVC alloc]init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case HMSPersonalCenterVCPushBtnTypeFeedBack:
        {
            HMSFeedBackVC *feedbackVC =[[HMSFeedBackVC alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        case HMSPersonalCenterVCPushBtnTypeClearCache:
        {
            CGFloat chcheSize =  [self folderSize];
            if (chcheSize<=0.01) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:@"当前无缓存文件，暂不需要清理" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.tag = 1001;
                [alert show];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"共产生%.2fM的文件，是否需要清除",chcheSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1000;
                [alert show];
            }
            
        }
            break;
        default:
            break;
    }
}

-(void)recommendToFriendBtnClick:(UIButton *)btn
{
    HMSSharePopView *sharePopView = [[HMSSharePopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [sharePopView show];
    sharePopView.popViewSelectAction = ^(NSInteger tag){
        NSLog(@"%ld",tag);
    };
}

-(void)didPressRightItem:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确定退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 2000;
    [alert show];
}

-(void)goPersonlInfoPage
{
    HMSPersonlInfoVC *personlInfoVC = [[HMSPersonlInfoVC alloc]init];
    personlInfoVC.dissmissVC =^{
        
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self viewDidLoad];
    };
    [self.navigationController pushViewController:personlInfoVC animated:YES];

}


// 缓存大小
- (CGFloat)folderSize{
    CGFloat folderSize;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return sizeM;
}

- (void)removeCache{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                
            }else{
                
                NSLog(@"清除失败");
                
            }
        }
    }
}


-(void)clearCache
{
    WS(ws);
    [SVProgressHUD showWithStatus:@"清理中..."];
    [self removeCache];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        ws.clearCacheSucessView =  [[HMSTipsView alloc]initWithTitle:@"清理缓存成功" icon:[UIImage imageNamed:@"clearCache_success"]];
        ws.clearCacheSucessView.alpha = 0;
        [ws.clearCacheSucessView showInView:[UIApplication sharedApplication].keyWindow];
        
        [UIView animateWithDuration:1.0 animations:^{
            ws.clearCacheSucessView.alpha = 1;
            
        }completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ws.clearCacheSucessView removeFromSuperview];
            });
        }];
    });
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
            [[HMSAccount shareAccount]loginOut];
            [HMSUtils changeRootVCtoLoginVC];
        }
    }else if (alertView.tag == 1000)
    {
        if (buttonIndex == 0)
        {
            
        }
        else if(buttonIndex == 1)
        {
            [self clearCache];
        }
    }
}



#pragma mark ---生产定制按钮工厂方法
-(UIButton *)buttonWithTitle:(NSString *)title rect:(CGRect )rect icon:(NSString *)icon isLine:(BOOL)isline btnPushType:(HMSPersonalCenterVCPushBtnType)pushType
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
    
    btn.tag =pushType;
    [btn addTarget:self action:@selector(pushBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (icon) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-65-15, 0, 65, 25)];
        imageView.image =[UIImage imageNamed:icon];
        imageView.centerY =btn.height *0.5;
        [btn addSubview:imageView];
    }else
    {
        UIImageView *arraw =[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-7-20, 0, 7, 15)];
        arraw.image =[UIImage imageNamed:@"personalCenter_garyArrow"];
        arraw.centerY =btn.height *0.5;
        [btn addSubview:arraw];
    }
    if(isline){
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, btn.height-1, btn.width, 1)];
        line.backgroundColor =HMSThemeBackgroundColor;
        line.alpha =1;
        [btn addSubview:line];
        
        
    }
    
    if ([title isEqualToString:@"我的老人"]||[title isEqualToString:@"关于我们"]) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(3,3)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
    }else if([title isEqualToString:@"账号信息"]||[title isEqualToString:@"清除缓存"])
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
    }
    
    
    return  btn;
}


@end

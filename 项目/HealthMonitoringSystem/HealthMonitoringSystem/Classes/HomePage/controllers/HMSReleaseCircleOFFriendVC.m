//
//  HMSReleaseCircleOFFriendVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/17.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSReleaseCircleOFFriendVC.h"
#import "LPDQuoteImagesView.h"
#import "HMSCircularView.h"
#import "HMSNetWorkManager.h"
#import "HMSSelectAddressVC.h"

@interface HMSReleaseCircleOFFriendVC ()<LPDQuoteImagesViewDelegate,UITextViewDelegate>
@property (nonatomic,strong)UIButton *sendBtn;

@property (nonatomic,strong) UIScrollView * BaseScrollView;

@property (nonatomic,strong)HMSCircularView *listViewOne;

@property (nonatomic,strong)UITextView *contentTextView;

@property (nonatomic,strong)UILabel *contentViewTipsLabel;

@property (nonatomic,strong)LPDQuoteImagesView *quoteImagesView;

@property (nonatomic,strong)UIButton *locationBtn;

@property(nonatomic,strong) UILabel *stringLenthLabel;


@property(nonatomic,strong) NSArray *fileNameArray;

@property(nonatomic,strong) NSString *currentAddress;

@property(nonatomic,strong) UIImageView *currentAddressIcon;

@property(nonatomic,strong) UILabel *currentAddressTitle;
@end

@implementation HMSReleaseCircleOFFriendVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.sendBtn = [self setNavRightItem:@"发送" normalColor:UIColorFromRGB(0xfb734f) highLTColor:nil fontSize:iPhone5_5s?16:17 size:CGSizeMake(60, 40)];
    [self.sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.sendBtn.enabled = NO;
    [self initView];
}


-(void)initView
{
    WS(ws);
    self.view.backgroundColor = HMSThemeBackgroundColor;
    self.BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    self.BaseScrollView.showsVerticalScrollIndicator =NO;
    self.BaseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BaseScrollView];
 
    
    self.listViewOne = [[HMSCircularView alloc]initWithFrame:CGRectMake(12, 12, self.BaseScrollView.width-24, 0)];
    self.listViewOne.backgroundColor =[UIColor whiteColor];
    [self.BaseScrollView addSubview:self.listViewOne];
   

    
    
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 20, self.listViewOne.width-40, self.releaseVCType==HMSReleaseCircleOFFriendVCText?120:80)];
    self.contentTextView.font = [UIFont systemFontOfSize:15];
    self.contentTextView.delegate = self;
    self.contentTextView.textColor = HMSThemeColor;
    self.contentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.listViewOne addSubview:self.contentTextView];
   
    
    self.contentViewTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, self.contentTextView.width-4, 35)];
    self.contentViewTipsLabel.numberOfLines = 0;
    self.contentViewTipsLabel.text = @"给亲友发条好消息吧";
    self.contentViewTipsLabel.textColor = [UIColor lightGrayColor];
    [self.contentTextView addSubview:self.contentViewTipsLabel];
    
   
    
   
    self.listViewOne.height = CGRectGetMaxY(self.contentTextView.frame)+12;
    
    if (self.releaseVCType!=HMSReleaseCircleOFFriendVCText) {
        self.quoteImagesView =[[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.contentTextView.frame)+12, self.contentTextView.width, self.contentTextView.width/3) withCountPerRowInView:3 cellMargin:20];
        self.quoteImagesView.maxSelectedCount = 9;
        //最大可选照片数
        
        self.quoteImagesView.collectionView.scrollEnabled = NO;
        //view可否滑动
        
        self.quoteImagesView.navcDelegate = self;    //self 至少是一个控制器。
        //委托（委托controller弹出picker，且不用实现委托方法）
        
        
        [self.listViewOne addSubview:self.quoteImagesView];
        self.quoteImagesView.changeHeight =^(CGFloat height){
            [UIView animateWithDuration:0.1 animations:^{
                ws.quoteImagesView.height = height;
                ws.listViewOne.height = CGRectGetMaxY(ws.quoteImagesView.frame)+12;
                [ws.listViewOne setNeedsDisplay];
                ws.locationBtn.y = CGRectGetMaxY(ws.listViewOne.frame)+1;
                ws.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(ws.locationBtn.frame)+12)>(ws.BaseScrollView.height+10)?(CGRectGetMaxY(ws.locationBtn.frame)+12):(ws.BaseScrollView.height+10));
                ws.stringLenthLabel.y = ws.listViewOne.height-15;
                if (ws.quoteImagesView.selectedPhotos.count>0||ws.contentTextView.text.length>0) {
                    ws.sendBtn.enabled =YES;
                }else
                {
                    ws.sendBtn.enabled =NO;
                }
            }];
            
        };
        
        if (self.typeOneImg) {
            [self.quoteImagesView addImage:self.typeOneImg];
        }
        self.listViewOne.height = CGRectGetMaxY(self.quoteImagesView.frame)+12;
    }
    
    self.stringLenthLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentRight];
    self.stringLenthLabel.frame = CGRectMake(self.listViewOne.width-15-150, self.listViewOne.height-15, 150, 15);
    [self.listViewOne addSubview:self.stringLenthLabel];
   
//
    NSArray *tempArray =[self buttonWithTitle:@"所在位置" image:[UIImage imageNamed:@"homepageRelease_locationBtn"] rect:CGRectMake(12, CGRectGetMaxY(self.listViewOne.frame)+1, KScreenWidth-24, 50)  clickAction:@selector(locationBtnClick:) viewController:self];
    self.locationBtn =[tempArray firstObject];
    self.currentAddressTitle =tempArray[1];
    self.currentAddressIcon =[tempArray lastObject];
    [self.BaseScrollView addSubview:self.locationBtn];
    
    self.BaseScrollView.contentSize =CGSizeMake(0, (CGRectGetMaxY(self.locationBtn.frame)+12)>(self.BaseScrollView.height+10)?(CGRectGetMaxY(self.locationBtn.frame)+12):(self.BaseScrollView.height+10));
}



-(void)locationBtnClick:(UIButton *)btn
{
    WS(ws);
    HMSSelectAddressVC *addressVC = [[HMSSelectAddressVC alloc]init];
    addressVC.currentAddress = [[self.currentAddress componentsSeparatedByString:@"·"] lastObject];
    addressVC.selectAddress = ^(NSString *address){
        ws.currentAddress = address;
        if (!address) {
            ws.currentAddressTitle.text = @"所在位置";
            ws.currentAddressIcon.image =[UIImage imageNamed:@"homepageRelease_locationBtn"];
        }else
        {
            ws.currentAddressTitle.text = address;
            ws.currentAddressIcon.image =[UIImage imageNamed:@"homepageRelease_useLocationBtn"];
        }
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

-(void)didPressRightItem:(UIButton *)btn
{
    WS(ws);
    [self.view endEditing:YES];
    
    if (self.quoteImagesView.selectedPhotos.count>0) {
        [HMSNetWorkManager uploadImages:self.quoteImagesView.selectedPhotos progress:^(CGFloat progress) {
            [SVProgressHUD showProgress:progress status:@"上传中..."];
        } success:^(NSArray *fileArray) {
            [SVProgressHUD dismiss];
            ws.fileNameArray = fileArray;
            [ws releaseContent];
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:error];
        }];
    }else
    {
        [self releaseContent];
    }
    
    
}

-(void)releaseContent
{
    WS(ws);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"content"] = self.contentTextView.text;
    params[@"image"] = self.fileNameArray;
    params[@"location"] = self.currentAddress?self.currentAddress:@"";
    
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/add-weibo" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (ws.controllerDismiss) {
                    ws.controllerDismiss();
                }
                [ws.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}




#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView == self.contentTextView) {
        if ([textView.text isEqualToString:@""]) {
            self.contentViewTipsLabel.text = @"给亲友发条好消息吧";
        }else{
            self.contentViewTipsLabel.text = @"";
        }
        
        if (self.contentTextView.text.length>0||self.quoteImagesView.selectedPhotos.count>0) {
            self.sendBtn.enabled =YES;
        }else
        {
            self.sendBtn.enabled =NO;
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

-(NSArray *)buttonWithTitle:(NSString *)title image:(UIImage *)image rect:(CGRect )rect clickAction:(SEL)clickAction viewController:(id)viewController
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =rect;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:HMSCustomColor(190, 190, 190)] forState:UIControlStateHighlighted];
    [btn addTarget:viewController action:clickAction forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 15, 21)];
    iconImageView.centerY =btn.height*0.5;
    iconImageView.image =image;
    [btn addSubview:iconImageView];
    
    UIImageView *arraw =[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-7-20, 0, 7, 15)];
    arraw.image =[UIImage imageNamed:@"personalCenter_garyArrow"];
    arraw.centerY =btn.height *0.5;
    [btn addSubview:arraw];
    
    UILabel *mainTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+12, 0, (arraw.x-10)-(CGRectGetMaxX(iconImageView.frame)+12), 20)];
    mainTitleLabel.font =HMSFOND(16);
    mainTitleLabel.textAlignment =NSTextAlignmentLeft;
    mainTitleLabel.textColor =[UIColor blackColor];
    mainTitleLabel.centerY =btn.height*0.5;
    mainTitleLabel.text =title;
//    mainTitleLabel.size = [title boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HMSFOND(15)} context:0].size;
    [btn addSubview:mainTitleLabel];
    
  
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    
    
    return  @[btn,mainTitleLabel,iconImageView];
}


-(void)dealloc
{
    NSLog(@"HMSReleaseCircleOFFriendVCdealloc");
}
@end

//
//  HMSMonitorDayReportOneView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMonitorDayReportOneView.h"
#import "UICountingLabel.h"
#import "HMSDayReportModel.h"

@interface HMSMonitorDayReportOneView ()
@property (weak, nonatomic) IBOutlet UICountingLabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sleepRankImgView;

@property (weak, nonatomic) IBOutlet UILabel *sleepRankTipsLabel;

@property (weak, nonatomic) IBOutlet UILabel *sleepStarLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sleepStartImgView;

@property (weak, nonatomic) IBOutlet UIImageView *sleepStarConstantView;


@property (weak, nonatomic) IBOutlet UILabel *sleepLenthLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sleepLenthImgView;

@property (weak, nonatomic) IBOutlet UIImageView *sleepLenthConstantView;


@property (weak, nonatomic) IBOutlet UILabel *sleepReadyTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sleepReadyTimeImgView;

@property (weak, nonatomic) IBOutlet UIImageView *sleepReadyConstantView;


@property (weak, nonatomic) IBOutlet UILabel *onBedTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *onBedTimeImgView;

@property (weak, nonatomic) IBOutlet UIImageView *onBedTimeConstantView;

@end
@implementation HMSMonitorDayReportOneView

+(instancetype)monitorDayReportOneView{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMSMonitorDayReportOneView"
                                          owner:nil options:nil]lastObject];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)setDayReportM:(HMSDayReportModel *)dayReportM
{
    _dayReportM = dayReportM;
    if (!dayReportM) {
        self.scoreLabel.text =@"0";
        
        self.sleepRankImgView.hidden = YES;
        
        self.sleepRankTipsLabel.text =@"你的睡眠评分击败了0%的用户";
        
        self.sleepStarLabel.text =@"00:00";
        self.sleepStartImgView.hidden = YES;
        self.sleepStarConstantView.hidden = YES;
        
        
        self.sleepLenthLabel.text =@"0";
        self.sleepLenthImgView.hidden = YES;
        self.sleepLenthConstantView.hidden = YES;
        
        self.sleepReadyTimeLabel.text =@"0";
        self.sleepReadyTimeImgView.hidden = YES;
        self.sleepReadyConstantView.hidden = YES;
        
        self.onBedTimeLabel.text =@"0";
        self.onBedTimeImgView.hidden = YES;
        self.onBedTimeConstantView.hidden = YES;
        
        return;
    }
    
    self.scoreLabel.text =dayReportM.score;
    
    self.sleepRankImgView.hidden = NO;
    if ([dayReportM.sleep_status isEqualToString:@"normal"]) {
        self.sleepRankImgView.image =[UIImage imageNamed:@"homepage_sleepNormel"];
    }else if([dayReportM.sleep_status isEqualToString:@"good"]){
        self.sleepRankImgView.image =[UIImage imageNamed:@"homepage_sleepGood"];
    }else if([dayReportM.sleep_status isEqualToString:@"subpar"]){
        self.sleepRankImgView.image =[UIImage imageNamed:@"homepage_sleepbad"];
    }
    
    self.sleepRankTipsLabel.text =[NSString stringWithFormat:@"你的睡眠评分击败了%@%%的用户",dayReportM.beat_percentage];
    
    self.sleepStarLabel.text =dayReportM.sleep_start;
    if ([dayReportM.sleep_start_tend isEqualToString:@"constant"]) {
        self.sleepStartImgView.hidden = YES;
        self.sleepStarConstantView.hidden = NO;
    }else if([dayReportM.sleep_start_tend isEqualToString:@"up"]){
        self.sleepStartImgView.hidden = NO;
        self.sleepStarConstantView.hidden = YES;
        self.sleepStartImgView.image =[UIImage imageNamed:@"monitor_arraw_up"];
    }else if([dayReportM.sleep_start_tend isEqualToString:@"down"]){
        self.sleepStartImgView.hidden = NO;
        self.sleepStarConstantView.hidden = YES;
        self.sleepStartImgView.image =[UIImage imageNamed:@"monitor_arraw_down"];
    }
    
    NSInteger sleepLenthMinute =[dayReportM.sleep_duration_minute integerValue];
    NSInteger m = sleepLenthMinute % 60;
    NSInteger h = (sleepLenthMinute - m) / 60 % 24;
    
    self.sleepLenthLabel.text =[NSString stringWithFormat:@"%dh%dm",h,m];
    if ([dayReportM.sleep_duration_minute_tend isEqualToString:@"constant"]) {
        self.sleepLenthImgView.hidden = YES;
        self.sleepLenthConstantView.hidden = NO;
    }else if([dayReportM.sleep_duration_minute_tend isEqualToString:@"up"]){
        self.sleepLenthImgView.hidden = NO;
        self.sleepLenthConstantView.hidden = YES;
        self.sleepLenthImgView.image =[UIImage imageNamed:@"monitor_arraw_up"];
    }else if([dayReportM.sleep_duration_minute_tend isEqualToString:@"down"]){
        self.sleepLenthImgView.hidden = NO;
        self.sleepLenthConstantView.hidden = YES;
        self.sleepLenthImgView.image =[UIImage imageNamed:@"monitor_arraw_down"];
    }
    
    self.sleepReadyTimeLabel.text =[NSString stringWithFormat:@"%@min",dayReportM.fall_sleep_minute];
    if ([dayReportM.fall_sleep_minute_tend isEqualToString:@"constant"]) {
        self.sleepReadyTimeImgView.hidden = YES;
        self.sleepReadyConstantView.hidden = NO;
    }else if([dayReportM.fall_sleep_minute_tend isEqualToString:@"up"]){
        self.sleepReadyTimeImgView.hidden = NO;
        self.sleepReadyConstantView.hidden = YES;
        self.sleepReadyTimeImgView.image =[UIImage imageNamed:@"monitor_arraw_up"];
    }else if([dayReportM.fall_sleep_minute_tend isEqualToString:@"down"]){
        self.sleepReadyTimeImgView.hidden = NO;
        self.sleepReadyConstantView.hidden = YES;
        self.sleepReadyTimeImgView.image =[UIImage imageNamed:@"monitor_arraw_down"];
    }
    
    
    NSInteger onBedTimeMinute =[dayReportM.on_bed_duration_minute integerValue];
    m = onBedTimeMinute % 60;
    h = (onBedTimeMinute - m) / 60 % 24;
    self.onBedTimeLabel.text =[NSString stringWithFormat:@"%dh%dm",h,m];
    if ([dayReportM.on_bed_duration_minute_tend isEqualToString:@"constant"]) {
        self.onBedTimeImgView.hidden = YES;
        self.onBedTimeConstantView.hidden = NO;
    }else if([dayReportM.on_bed_duration_minute_tend isEqualToString:@"up"]){
        self.onBedTimeImgView.hidden = NO;
        self.onBedTimeConstantView.hidden = YES;
        self.onBedTimeImgView.image =[UIImage imageNamed:@"monitor_arraw_up"];
    }else if([dayReportM.on_bed_duration_minute_tend isEqualToString:@"down"]){
        self.onBedTimeImgView.hidden = NO;
        self.onBedTimeConstantView.hidden = YES;
        self.onBedTimeImgView.image =[UIImage imageNamed:@"monitor_arraw_down"];
    }
}


@end

//
//  HMSDateSelectView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSDateSelectView.h"

@interface HMSDateSelectView ()

/** 左边button*/
@property(nonatomic,strong) UIButton *leftButton;
/** 右边button*/
@property(nonatomic,strong) UIButton *rightButton;
/** 日期label*/
@property(nonatomic,strong) UILabel *centerLabel;
//日期类型切换按钮
@property(nonatomic,strong) UIButton *dayBtn;

/** 每月日期*/
@property(nonatomic,strong) NSString *dayByMonthString;

/** 索引*/
@property(nonatomic,assign) int index;

/** 月份索引*/
@property(nonatomic,assign) int monthIndex;

@end
@implementation HMSDateSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        self.index =0;
        self.monthIndex =0;
        [self getDay];
        [self getMonth];
        
        [self initView];
    }
    return self;
}


#pragma -mark 获取上/下月份
-(NSString *)getOtherMonthDate:(int)tap{
    NSTimeInterval secondsPerDay = (24 * 60 * 60 * 29.4)*tap;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDate *month = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM"];
    [dateFormtter setTimeZone:zone];
    return  self.monthString =[dateFormtter stringFromDate: month];
}

#pragma -mark 获取当月日期
-(NSString *)getMonth{
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [dateFormtter setDateFormat:@"yyyy-MM"];
    [dateFormtter setTimeZone:zone];
    self.monthString = [dateFormtter stringFromDate:[NSDate date]];
    return self.monthString;
}

#pragma -mark 获取昨天日期
-(NSString *)getDay{
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    [dateFormtter setTimeZone:zone];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    self.dateString = [dateFormtter stringFromDate:yesterday];
    return self.dateString;
}

#pragma -mark 获取前一天/后一天日期
-(NSString *)getOtherDate:(int)tap{
    NSTimeInterval secondsPerDay = (24 * 60 * 60)*tap;
    NSDate *yesterdayDate = [[NSDate alloc]initWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    NSDate *tomorrowOrYesterday = [yesterdayDate initWithTimeInterval:secondsPerDay sinceDate:yesterdayDate];
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    return self.dateString=[dateFormtter stringFromDate:tomorrowOrYesterday];
}


-(void)initView{

    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(7, 0, 44, self.height)];
    [self.leftButton setImage:[UIImage imageNamed:@"monitor_selector_left"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"monitor_selector_left_gary"] forState:UIControlStateDisabled];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    
    CGFloat labelWidth = [@"0000.00.00" mh_sizeWithFont:HMSFOND(15) limitWidth:self.width*0.45].width;
    self.centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftButton.frame)-5, 0, labelWidth, self.height)];
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    self.centerLabel.textColor = [UIColor blackColor];
    self.centerLabel.font =HMSFOND(15);
    self.centerLabel.text =[self.dateString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    [self addSubview:self.centerLabel];
    
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.centerLabel.frame) -5, 0, 44, self.height)];
    [self.rightButton setImage:[UIImage imageNamed:@"monitor_selector_right"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"monitor_selector_right_gary"] forState:UIControlStateDisabled];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    
    
    UIButton *shareBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.width -44-10, 0, 44, self.height)];
    [shareBtn setImage:[UIImage imageNamed:@"monitor_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];
    
    UIButton *dayBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.width -44-10-5-80, 0, 80, self.height)];
    [dayBtn setImage:[UIImage imageNamed:@"monitor_header_day"] forState:UIControlStateNormal];
    [dayBtn setImage:[UIImage imageNamed:@"monitor_header_month"] forState:UIControlStateSelected];
    [dayBtn addTarget:self action:@selector(dayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.dayBtn =dayBtn;
    [self addSubview:dayBtn];
}



-(void)leftButtonClick:(UIButton *)btn
{
    if (self.dayBtn.selected) {
        //日期类型选择器为月份时
        self.monthString = [self getOtherMonthDate:--self.monthIndex];
        self.centerLabel.text =[self.monthString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if (self.monthIndex>=0) {
            self.rightButton.enabled =NO;
        }else
        {
            self.rightButton.enabled =YES;
        }
        if ([self.delegate respondsToSelector:@selector(dateSelectorViewMonthSelect:withMonthDateString:)]) {
            [self.delegate dateSelectorViewMonthSelect:self withMonthDateString:self.monthString];
        }
        
    }else
    {
        self.dateString = [self getOtherDate:--self.index];
        self.centerLabel.text =[self.dateString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if (self.index>=1) {
            self.rightButton.enabled =NO;
        }else
        {
            self.rightButton.enabled =YES;
        }
        if ([self.delegate respondsToSelector:@selector(dateSelectorViewDaySelect:withDateString:)]) {
            [self.delegate dateSelectorViewDaySelect:self withDateString:self.dateString];
        }
    }
}

-(void)rightButtonClick:(UIButton *)btn
{
    if (self.dayBtn.selected) {
        //日期类型选择器为月份时
        self.monthString = [self getOtherMonthDate:++self.monthIndex];
        self.centerLabel.text =[self.monthString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if (self.monthIndex>=0) {
            self.rightButton.enabled =NO;
        }else
        {
            self.rightButton.enabled =YES;
        }
        if ([self.delegate respondsToSelector:@selector(dateSelectorViewMonthSelect:withMonthDateString:)]) {
            [self.delegate dateSelectorViewMonthSelect:self withMonthDateString:self.monthString];
        }
        
    }else{
        self.dateString = [self getOtherDate:++self.index];
        self.centerLabel.text =[self.dateString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        
        if (self.index>=1) {
            self.rightButton.enabled =NO;
        }else
        {
            self.rightButton.enabled =YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(dateSelectorViewDaySelect:withDateString:)]) {
            [self.delegate dateSelectorViewDaySelect:self withDateString:self.dateString];
        }
    }
}

-(void)shareClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(dateSelectorViewDidClickShareBtn:)]) {
        [self.delegate dateSelectorViewDidClickShareBtn:self];
    }
}

-(void)dayBtnClick:(UIButton *)btn
{
    btn.selected=!btn.selected;
    
    if ([self.delegate respondsToSelector:@selector(dateSelectorViewChangeDayOrMonth:didChangeMonth:)]) {
        [self.delegate dateSelectorViewChangeDayOrMonth:self didChangeMonth:btn.selected];
    }
    if (btn.selected) {
        self.centerLabel.text =[self.monthString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if (self.monthIndex>=0) {
            self.rightButton.enabled =NO;
        }else
        {
            self.rightButton.enabled =YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(dateSelectorViewMonthSelect:withMonthDateString:)]) {
            [self.delegate dateSelectorViewMonthSelect:self withMonthDateString:self.monthString];
        }
    }else
    {
        self.centerLabel.text =[self.dateString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if (self.index>=1) {
            self.rightButton.enabled =NO;
        }else
        {
            self.rightButton.enabled =YES;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end

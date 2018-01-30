//
//  HMSDateSelectView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSDateSelectView;
@protocol HMSDateSelectViewDelegate <NSObject>

@optional

//点击选择日期通知代理
-(void)dateSelectorViewDaySelect:(HMSDateSelectView *)selectorView withDateString:(NSString *)dateStr;

//点击选择月份通知代理
-(void)dateSelectorViewMonthSelect:(HMSDateSelectView *)selectorView withMonthDateString:(NSString *)monthStr;

//点击选择月或日
-(void)dateSelectorViewChangeDayOrMonth:(HMSDateSelectView *)selectorView didChangeMonth:(BOOL)isMonth;

//点击分享按钮
-(void)dateSelectorViewDidClickShareBtn:(HMSDateSelectView *)selectorView;
@end

@interface HMSDateSelectView : UIView

@property(nonatomic,weak) id<HMSDateSelectViewDelegate> delegate;
/** 日期*/
@property(nonatomic,strong) NSString *dateString;
/** 月份*/
@property(nonatomic,strong) NSString *monthString;
@end

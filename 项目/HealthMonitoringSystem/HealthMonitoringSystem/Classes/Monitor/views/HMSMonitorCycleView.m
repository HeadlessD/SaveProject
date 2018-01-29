//
//  HMSMonitorCycleView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/26.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMonitorCycleView.h"
#import "HMSSleepPercentView.h"
#import "HMSDayReportModel.h"

@interface HMSMonitorCycleView ()
@property (weak, nonatomic) IBOutlet HMSSleepPercentView *deepSleepView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *lightSleepView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *remSleepView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *awakSleepViw;

@end
@implementation HMSMonitorCycleView

+(instancetype)monitorCycleView{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMSMonitorCycleView"
                                          owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.deepSleepView.lineColor = UIColorFromRGB(0x0d47a1);
    self.deepSleepView.percent = 0.25;
    self.lightSleepView.lineColor = UIColorFromRGB(0x1976d2);
    self.lightSleepView.percent = 0.5;
    self.remSleepView.lineColor = UIColorFromRGB(0x42a5f5);
    self.remSleepView.percent = 0.75;
    self.awakSleepViw.lineColor = UIColorFromRGB(0x64b5f5);
    self.awakSleepViw.percent = 1;
    
}

-(void)setDayReportM:(HMSDayReportModel *)dayReportM
{
    _dayReportM = dayReportM;
    if (!dayReportM) {
        self.deepSleepView.percent =0;
        self.lightSleepView.percent =0;
        self.remSleepView.percent =0;
        self.awakSleepViw.percent =0;
        return;
    }
    
    [self.deepSleepView reloadViewWithPercent:[dayReportM.deep_percentage intValue]*0.01];
    [self.lightSleepView reloadViewWithPercent:[dayReportM.light_percentage intValue]*0.01];
    [self.remSleepView reloadViewWithPercent:[dayReportM.rem_percentage intValue]*0.01];
    [self.awakSleepViw reloadViewWithPercent:[dayReportM.awake_percentage intValue]*0.01];
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

@end

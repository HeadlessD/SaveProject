//
//  HMSSleepReportCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSleepReportCell.h"
#import "UICountingLabel.h"
#import "HMSSleepPercentView.h"
#import "HMSHomePage_sleepReport.h"

@interface HMSSleepReportCell ()
@property (weak, nonatomic) IBOutlet UILabel *sleepStarAndEndTitleLabel;

@property (weak, nonatomic) IBOutlet UICountingLabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sleepRankImgView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *deepAnimationView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *lightAnimationView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *remAnimationView;

@property (weak, nonatomic) IBOutlet HMSSleepPercentView *awakAnimationView;

@end
@implementation HMSSleepReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.deepAnimationView.lineColor = UIColorFromRGB(0x0d47a1);
    self.deepAnimationView.percent = 0;
    self.lightAnimationView.lineColor = UIColorFromRGB(0x1976d2);
    self.lightAnimationView.percent = 0;
    self.remAnimationView.lineColor = UIColorFromRGB(0x42a5f5);
    self.remAnimationView.percent = 0;
    self.awakAnimationView.lineColor = UIColorFromRGB(0x64b5f5);
    self.awakAnimationView.percent = 0;
    
    self.scoreLabel.format = @"%ld";
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSleep_report:(HMSHomePage_sleepReport *)sleep_report
{
    
    _sleep_report = sleep_report;
    if (!sleep_report) {
        self.sleepStarAndEndTitleLabel.text = @"00:00~00:00";
        self.scoreLabel.text = @"0";
        self.deepAnimationView.percent = 0;
        self.lightAnimationView.percent = 0;
        self.remAnimationView.percent = 0;
        self.awakAnimationView.percent = 0;
        self.sleepRankImgView.hidden =YES;
        return;
    }
    self.sleepStarAndEndTitleLabel.text = [NSString stringWithFormat:@"%@~%@",sleep_report.sleep_start,sleep_report.sleep_end];
    [self.scoreLabel countFrom:0 to:[sleep_report.score integerValue] withDuration:1];
    
    [self.deepAnimationView reloadViewWithPercent:[sleep_report.deep_percentage intValue]*0.01];
    [self.lightAnimationView reloadViewWithPercent:[sleep_report.light_percentage intValue]*0.01];
    [self.remAnimationView reloadViewWithPercent:[sleep_report.rem_percentage intValue]*0.01];
    [self.awakAnimationView reloadViewWithPercent:[sleep_report.awake_percentage intValue]*0.01];
  
    
    if (sleep_report.sleep_status.length>0) {
        self.sleepRankImgView.hidden =NO;
        if ([sleep_report.sleep_status isEqualToString:@"normal"]) {
            self.sleepRankImgView.image =[UIImage imageNamed:@"homepage_sleepNormel"];
        }else if([sleep_report.sleep_status isEqualToString:@"good"]){
            self.sleepRankImgView.image =[UIImage imageNamed:@"homepage_sleepGood"];
        }else if([sleep_report.sleep_status isEqualToString:@"subpar"]){
           self.sleepRankImgView.image =[UIImage imageNamed:@"homepage_sleepbad"]; 
        }
            
    }
}

@end

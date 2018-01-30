//
//  HMSMyOldManCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMyOldManCell.h"
#import <UIImageView+WebCache.h>
#import "HMSOldManModel.h"
@interface HMSMyOldManCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation HMSMyOldManCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setOldManM:(HMSOldManModel *)oldManM
{
    _oldManM = oldManM;
    
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:oldManM.avatar] placeholderImage:[UIImage imageNamed:[oldManM.sex isEqualToString:@"0"]?@"defaul_oldManHeaderImg":@"defaul_oldWomanHeaderImg"]];
    self.sexImgView.image =[UIImage imageNamed:[oldManM.sex isEqualToString:@"0"]?@"oldMan_man":@"oldMan_woman"];
    self.titleLabel.text = oldManM.name;
    
}
@end

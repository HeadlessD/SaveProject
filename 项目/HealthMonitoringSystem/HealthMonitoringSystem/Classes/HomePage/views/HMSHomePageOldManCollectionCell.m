//
//  HMSHomePageOldManCollectionCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageOldManCollectionCell.h"
#import "HMSOldManModel.h"
#import <UIImageView+WebCache.h>
@interface HMSHomePageOldManCollectionCell ()


@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;

@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sleepStateImgView;



@end
@implementation HMSHomePageOldManCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick)];
    [self.headerImgView addGestureRecognizer:tapG];
    self.headerImgView.userInteractionEnabled =YES;
}

- (IBAction)oldManCardAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(oldManCardCellDidClickInviteBtn:addFriend:)]) {
        [self.delegate oldManCardCellDidClickInviteBtn:self addFriend:self.oldManM];
    }
}

-(void)headerViewClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(oldManCardCellDidClickHeaderImg:addFriend:)]) {
        [self.delegate oldManCardCellDidClickHeaderImg:self addFriend:self.oldManM];
    }
}


-(void)setOldManM:(HMSOldManModel *)oldManM
{
    _oldManM = oldManM;
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:oldManM.avatar] placeholderImage:[UIImage imageNamed:[oldManM.sex isEqualToString:@"0"]?@"defaul_oldManHeaderImg":@"defaul_oldWomanHeaderImg"]];
    self.nikeNameLabel.text = oldManM.name;
    self.sexImgView.image =[UIImage imageNamed:[oldManM.sex isEqualToString:@"0"]?@"oldMan_man":@"oldMan_woman"];
    self.roleLabel.text = oldManM.role;
    //self.titleLabel.text = oldManM.name;
}
@end

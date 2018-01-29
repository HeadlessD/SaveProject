//
//  HMSHomePageLikeHeaderImgCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/20.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageLikeHeaderImgCell.h"
#import <UIImageView+WebCache.h>
@interface HMSHomePageLikeHeaderImgCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@end
@implementation HMSHomePageLikeHeaderImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setHeaderImg:(NSString *)headerImg
{
    _headerImg = headerImg;
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:headerImg] placeholderImage:[UIImage imageNamed:@"defaul_manHeaderImg"]];
}
@end

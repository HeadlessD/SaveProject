//
//  HMSOldManFriendShipCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSOldManFriendShipCell.h"
#import "HMSOldManModel.h"
#import <UIImageView+WebCache.h>

@interface HMSOldManFriendShipCell ()


@end
@implementation HMSOldManFriendShipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)setFriendModel:(HMSOldManFriendModel *)friendModel
{
    _friendModel = friendModel;
    
    [self.friendHeaderImagView sd_setImageWithURL:[NSURL URLWithString:friendModel.avatar] placeholderImage:[UIImage imageNamed:[friendModel.sex isEqualToString:@"0"]?@"defaul_manHeaderImg":@"defaul_womanHeaderImg"]];
    self.nikeNameTitle.text = friendModel.username;
    
}

@end

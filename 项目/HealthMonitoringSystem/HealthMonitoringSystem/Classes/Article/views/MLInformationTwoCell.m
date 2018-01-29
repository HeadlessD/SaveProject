//
//  MLInformationTwoCell.m
//  mlily
//
//  Created by gw on 2016/11/24.
//  Copyright © 2016年 mirahome. All rights reserved.
//

#import "MLInformationTwoCell.h"
#import "HMSArticleModel.h"
#import <UIImageView+WebCache.h>

@interface MLInformationTwoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@end
@implementation MLInformationTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArticlModel:(HMSArticleModel *)articlModel
{
    _articlModel = articlModel;
    self.bodyLabel.text = articlModel.title;
    [self.backImage  sd_setImageWithURL:[NSURL URLWithString:articlModel.thumb] placeholderImage:[UIImage imageNamed:@"cell_normol_pic"]];
    
    self.timeLabel.text = articlModel.timeStr;
    
   
    
}


@end

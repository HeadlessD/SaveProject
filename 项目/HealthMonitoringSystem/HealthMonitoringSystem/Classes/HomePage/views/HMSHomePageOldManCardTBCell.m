//
//  HMSHomePageOldManCardTBCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageOldManCardTBCell.h"

@interface HMSHomePageOldManCardTBCell ()


@property (nonatomic,strong) UIImageView *imageBGView;
@end
@implementation HMSHomePageOldManCardTBCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
//    self.backgroundColor =[UIColor clearColor];
    self.imageBGView = [[UIImageView alloc]init];
    self.imageBGView.image = [UIImage imageNamed:@"homePage_bannerTwo"];
    [self.contentView addSubview:self.imageBGView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(290, 120);
    layout.minimumInteritemSpacing = 12;
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMSHomePageOldManCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HMSHomePageOldManCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMSHomePageAddOldManCell" bundle:nil] forCellWithReuseIdentifier:@"HMSHomePageAddOldManCell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 12);
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.showsHorizontalScrollIndicator =NO;
    [self.contentView addSubview:self.collectionView];
    
    
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageBGView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height-6);
    
    self.collectionView.frame = CGRectMake(0, 16, KScreenWidth, 120);
}


@end

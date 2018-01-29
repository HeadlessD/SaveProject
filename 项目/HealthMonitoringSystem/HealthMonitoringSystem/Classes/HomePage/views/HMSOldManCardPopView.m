//
//  HMSOldManCardPopView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/21.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSOldManCardPopView.h"
#import "HMSOldManModel.h"
#import <UIImageView+WebCache.h>
#import "HMSOldManFriendShipCell.h"

@interface HMSOldManCardPopView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIView *backView;

@property (nonatomic,strong)UICollectionView *friendAndRelativeCollectionView;

@property (nonatomic,strong)HMSOldManModel *oldManM;
@end
@implementation HMSOldManCardPopView

-(instancetype)initWithFrame:(CGRect)frame oldManModel:(HMSOldManModel *)oldMan
{
     if (self = [super initWithFrame:frame]) {
         if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
             UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
             UIVisualEffectView*  blur = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
             blur.frame = self.frame;
             [self addSubview:blur];
         }else {
             self.backgroundColor = HMSCustomARGBColor(0, 0, 0, 0.7);
         }
         
         self.oldManM = oldMan;
         UIView *clickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
         [self addSubview:clickView];
         UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disShow)];
         [clickView addGestureRecognizer:tapG];
         
         self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, 300, 340)];
         self.backView.centerX= self.width *0.5;
         self.backView.centerY = self.height*0.5;
         self.backView.layer.cornerRadius = 5;
         self.backView.clipsToBounds =YES;
         self.backView.backgroundColor =[UIColor whiteColor];
         [self addSubview:self.backView];
         
         
         UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(45, 30, 90, 90)];
         headerImgView.layer.cornerRadius = 45;
         headerImgView.clipsToBounds =YES;
         [headerImgView sd_setImageWithURL:[NSURL URLWithString:oldMan.avatar] placeholderImage:[UIImage imageNamed:[oldMan.sex isEqualToString:@"0"]?@"defaul_oldManHeaderImg":@"defaul_oldWomanHeaderImg"]];
         [self.backView addSubview:headerImgView];
         
         
         UILabel *nikeName =[UILabel labelWithTitle:oldMan.name Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
         CGFloat nikeNameX = CGRectGetMaxX(headerImgView.frame)+15;
         CGSize nikeSize = [oldMan.name mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(self.backView.width-45-nikeNameX, 15)];
         nikeName.frame = CGRectMake(nikeNameX, 0, nikeSize.width, nikeSize.height);
         nikeName.centerY = headerImgView.centerY;
         [self.backView addSubview:nikeName];
         
         UIView *deviderView = [[UIView alloc]initWithFrame:CGRectMake(headerImgView.x, CGRectGetMaxY(headerImgView.frame)+20, self.backView.width-90, 1)];
         deviderView.backgroundColor = HMSThemeDeviderColor;
         [self.backView addSubview:deviderView];
         
         UILabel *titleLabel =[UILabel labelWithTitle:@"亲友团" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
         CGSize titleLSize = [titleLabel.text mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(150, 15)];
         titleLabel.frame = (CGRect){{headerImgView.x,CGRectGetMaxY(deviderView.frame)+12},titleLSize};
         [self.backView addSubview:titleLabel];
         
         
         UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
         collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
         collectionViewFlowLayout.itemSize = CGSizeMake(50, 70);
         collectionViewFlowLayout.minimumLineSpacing = 20;
         //    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
         
        
         
         self.friendAndRelativeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(headerImgView.x, CGRectGetMaxY(titleLabel.frame)+20, deviderView.width, 70) collectionViewLayout:collectionViewFlowLayout];
         self.friendAndRelativeCollectionView.dataSource = self;
         self.friendAndRelativeCollectionView.delegate = self;
         self.friendAndRelativeCollectionView.alwaysBounceHorizontal = YES;
         self.friendAndRelativeCollectionView.showsHorizontalScrollIndicator =NO;
         self.friendAndRelativeCollectionView.backgroundColor = [UIColor clearColor];    //加载控件
         //self.friendAndRelativeCollectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
         [self.backView addSubview:self.friendAndRelativeCollectionView];
         
         [self.friendAndRelativeCollectionView registerNib:[UINib nibWithNibName:@"HMSOldManFriendShipCell" bundle:nil] forCellWithReuseIdentifier:@"HMSOldManFriendShipCell"];
          
         
         UIButton *addFriendBtn =[UIButton buttonWithImage:[UIImage imageNamed:@"oldMan_addMan"] highLightImg:nil BGColor:nil clickAction:@selector(addFriendBtnClick:) viewController:self cornerRadius:0];
         addFriendBtn.frame = (CGRect){{headerImgView.x,CGRectGetMaxY(self.friendAndRelativeCollectionView.frame)+10},{40,40}};
         [self.backView addSubview:addFriendBtn];
         
     }
    return self;
}


-(void)addFriendBtnClick:(UIButton *)btn
{
    if (self.inviteBtnClick) {
        [self disShow];
        self.inviteBtnClick(self.oldManM.oldMan_id);
    }
}

-(void)disShow
{
    WS(ws);
    [UIView animateWithDuration:0.2 animations:^{
        ws.backView.y = ws.height;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            ws.alpha = 0;
        }completion:^(BOOL finished) {
            [ws removeFromSuperview];
        }];
    }];
}

-(void)show
{
    self.alpha = 0;
    WS(ws);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        ws.alpha = 1;
        
    }completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark ---------------- UICollectionViewDelegate,DataSource---------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.oldManM.friend_relative_group.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMSOldManFriendShipCell *cell = [self.friendAndRelativeCollectionView dequeueReusableCellWithReuseIdentifier:@"HMSOldManFriendShipCell" forIndexPath:indexPath];
    cell.friendModel = self.oldManM.friend_relative_group[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
}


@end

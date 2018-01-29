//
//  HMSHomePageTopicCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/19.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageTopicCell.h"
#import "HMSWeiboModel.h"
#import "HMSWeiboFrame.h"
#import <UIImageView+WebCache.h>
#import "XLPhotoBrowser.h"
#import "HMSHomePageCommentCell.h"
#import "HMSWeiboCommetFrame.h"
#import "HMSHomePageLikeHeaderImgCell.h"

@interface HMSHomePageTopicCell ()<XLPhotoBrowserDelegate,XLPhotoBrowserDatasource,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,HMSHomePageCommentCellDelegate>
@property (nonatomic,strong) UIView *whiteBGView;

@property (nonatomic,strong) UIImageView *headerImgView;

@property (nonatomic,strong) UILabel *nikeNameLabel;

@property (nonatomic,strong) UIImageView *sexImgView;

@property (nonatomic,strong) UILabel *createTimeLabel;

@property (nonatomic,strong) UIButton *deleteBtn;

@property (nonatomic,strong) UILabel *contentText;

@property (nonatomic,strong) UIView *pictureBGView;

@property (nonatomic,strong) NSMutableArray<UIImageView *> *pictureViewArray;

@property (nonatomic,strong) UILabel *locationLabel;

@property (nonatomic,strong) UIButton *likeBtn;

@property (nonatomic,strong) UILabel *likeLabel;

@property (nonatomic,strong) UIButton *commentBtn;

@property (nonatomic,strong) UILabel *commentLabel;

@property (nonatomic,strong) UIButton *repeatBtn;

@property (nonatomic,strong) UICollectionView *likeHeaderCollectionView;

@property (nonatomic,strong) UILabel *likeHeaderCollectionViewRightLabel;

@property (nonatomic,strong) UIView *likeHeaderCollectionViewDivider;

@property (nonatomic,strong) UITableView *commentTableView;

@end
@implementation HMSHomePageTopicCell
-(NSMutableArray *)pictureViewArray
{
    if (!_pictureViewArray) {
        _pictureViewArray = [NSMutableArray array];
    }
    return _pictureViewArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HMSHomePageTopicCell";
    HMSHomePageTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
        
    }
    
    return self;
}


#pragma mark - 公共方法
#pragma mark - Setter
-(void)setWeiboFrame:(HMSWeiboFrame *)weiboFrame
{
    _weiboFrame = weiboFrame;
    HMSWeiboModel *weiboM = weiboFrame.weibo;
    for (UIImageView *tempView in self.pictureViewArray) {
        [tempView setHidden:YES];
    }
    
 
    self.whiteBGView.frame =weiboFrame.writeBGFrame;
    
    self.headerImgView.frame = weiboFrame.avatarFrame;
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:weiboM.weibo_author_avatar] placeholderImage:[UIImage imageNamed:[weiboM.weibo_author_sex isEqualToString:@"0"]?@"defaul_manHeaderImg":@"defaul_womanHeaderImg"]];
    
    self.nikeNameLabel.frame = weiboFrame.nikeNameFrame;
    self.nikeNameLabel.text = weiboM.weibo_author_name;
    
    self.sexImgView.frame = weiboFrame.sexFrame;
    self.sexImgView.image = [weiboM.weibo_author_sex isEqualToString:@"0"]?[UIImage imageNamed:@"personalCenter_man"]:[UIImage imageNamed:@"personalCenter_woman"];
    
    
    self.createTimeLabel.frame = weiboFrame.createTimeFrame;
    self.createTimeLabel.text = weiboM.weibo_created_time;
    
    self.deleteBtn.frame = weiboFrame.deleteBtnFrame;
    
    self.contentText.frame = weiboFrame.textFrame;
    self.contentText.text = weiboM.weibo_content;
    
    self.pictureBGView.frame = weiboFrame.picViewFrame;
    
    int i=0;
    if (weiboFrame.picFramesArray.count>0) {
        for (UIImageView *tempImgView in self.pictureViewArray) {
            [tempImgView setHidden:NO];
            tempImgView.frame = [weiboFrame.picFramesArray[i] CGRectValue];
            UIImage *placeholderImage = weiboFrame.picFramesArray.count==1?[UIImage imageNamed:@"homePage_placeholderImg2"]:[UIImage imageNamed:@"homePage_placeholderImg1"];
            [tempImgView sd_setImageWithURL:[NSURL URLWithString:weiboM.weibo_image[i]] placeholderImage:placeholderImage];
            i++;
            if (i==weiboFrame.picFramesArray.count) {
                break;
            }
        }
    }
    
    
    if (weiboM.location.length>0) {
        NSString *locationStr = [[weiboM.location componentsSeparatedByString:@"·"] componentsJoinedByString:@" "];
        self.locationLabel.text = locationStr;
    }
    self.locationLabel.frame = weiboFrame.locationFrame;
    
    self.likeBtn.frame = weiboFrame.likeViewFrame;
    
    self.likeLabel.frame = weiboFrame.likeLabelFrame;
    self.likeLabel.text = [NSString stringWithFormat:@"%ld次",weiboM.praise.count];
    
    self.commentBtn.frame = weiboFrame.commentViewFrame;
    
    self.commentLabel.frame = weiboFrame.commentLabelFrame;
    self.commentLabel.text = [NSString stringWithFormat:@"%ld条",weiboM.comment.count];
    
    self.repeatBtn.frame=  weiboFrame.repeatBtnFrame;
    
    self.likeHeaderCollectionView.frame = weiboFrame.likeCollectionFrame;
    [self.likeHeaderCollectionView reloadData];
    
    self.likeHeaderCollectionViewRightLabel.frame = weiboFrame.likeCollectionLeftLabelFrame;
    self.likeHeaderCollectionViewDivider.frame = weiboFrame.likeCollectionDividerFrame;
    
    self.commentTableView.frame = weiboFrame.commentTableViewFrame;
    [self.commentTableView reloadData];
    
    self.deleteBtn.hidden =YES;
    if (weiboM.is_delete) {
         self.deleteBtn.hidden =NO;
    }
    if (weiboM.is_praise) {
        [self.likeBtn setImage:[UIImage imageNamed:@"homepage_like_select"] forState:UIControlStateNormal];
    }else
    {
         [self.likeBtn setImage:[UIImage imageNamed:@"homepage_like"] forState:UIControlStateNormal];
    }
    
}

#pragma mark - 私有方法
#pragma mark - 初始化
- (void)_setup
{
    // 设置颜色
    self.contentView.backgroundColor = [UIColor clearColor];
}


#pragma mark - 创建自控制器
- (void)_setupSubViews
{
    self.whiteBGView = [[UIView alloc]init];
    self.whiteBGView.backgroundColor =[UIColor whiteColor];
    self.whiteBGView.layer.cornerRadius =3;
    self.whiteBGView.clipsToBounds = YES;
    [self.contentView addSubview:self.whiteBGView];
    
    self.headerImgView = [[UIImageView alloc]init];
    self.headerImgView.image =[UIImage imageNamed:@"defaul_manHeaderImg"];
    self.headerImgView.layer.cornerRadius = 20;
    self.headerImgView.clipsToBounds = YES;
    [self.whiteBGView addSubview:self.headerImgView];
    
    self.nikeNameLabel = [UILabel labelWithTitle:@"" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    [self.whiteBGView addSubview:self.nikeNameLabel];
    
    self.sexImgView = [[UIImageView alloc]init];
    [self.whiteBGView addSubview:self.sexImgView];
    
    self.createTimeLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
    [self.whiteBGView addSubview:self.createTimeLabel];
    
    self.deleteBtn = [UIButton buttonWithTitle:@"删除" font:HMSFOND(12) TitleColor:[UIColor darkGrayColor] BGColor:nil clickAction:@selector(deleteBtnAction:) viewController:self cornerRadius:0];
    [self.whiteBGView addSubview:self.deleteBtn];
    
    
    self.contentText = [UILabel labelWithTitle:@"" Color:[UIColor darkGrayColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentLeft];
    self.contentText.numberOfLines = 0;
    [self.whiteBGView addSubview:self.contentText];
    
    self.pictureBGView = [[UIView alloc]init];
    [self.whiteBGView addSubview:self.pictureBGView];
    
    for (int i =0; i<9; i++) {
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        UIImageView *tempImaView =[[UIImageView alloc]init];
        tempImaView.userInteractionEnabled =YES;
        tempImaView.tag = i;
        tempImaView.layer.cornerRadius = 3;
        tempImaView.clipsToBounds = YES;
        [self.pictureBGView addSubview:tempImaView];
        [self.pictureViewArray addObject:tempImaView];
        [tempImaView addGestureRecognizer:tap];
    }
    
    self.locationLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(10) textAlignment:NSTextAlignmentLeft];
    [self.whiteBGView addSubview:self.locationLabel];
    
    self.likeBtn =[UIButton buttonWithImage:[UIImage imageNamed:@"homepage_like"] highLightImg:nil BGColor:nil clickAction:@selector(likeBtnClick:) viewController:self cornerRadius:0];
    [self.whiteBGView addSubview:self.likeBtn];
    
    self.likeLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
    [self.whiteBGView addSubview:self.likeLabel];
    
    self.commentBtn =[UIButton buttonWithImage:[UIImage imageNamed:@"homepage_comment"] highLightImg:nil BGColor:nil clickAction:@selector(commentBtnClick:) viewController:self cornerRadius:0];
    [self.whiteBGView addSubview:self.commentBtn];
    
    self.commentLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
    [self.whiteBGView addSubview:self.commentLabel];
    
    self.repeatBtn =[UIButton buttonWithImage:[UIImage imageNamed:@"homepage_repeat"] highLightImg:nil BGColor:nil clickAction:@selector(repeatBtnClick:) viewController:self cornerRadius:0];
    [self.whiteBGView addSubview:self.repeatBtn];
    
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.itemSize = CGSizeMake(30, 30);
    collectionViewFlowLayout.minimumLineSpacing = 12;
    //    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
    
    self.likeHeaderCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
    self.likeHeaderCollectionView.dataSource = self;
    self.likeHeaderCollectionView.delegate = self;
    self.likeHeaderCollectionView.alwaysBounceHorizontal = YES;
    self.likeHeaderCollectionView.showsHorizontalScrollIndicator =NO;
    self.likeHeaderCollectionView.backgroundColor = [UIColor clearColor];    //加载控件
    self.likeHeaderCollectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [self.whiteBGView addSubview:self.likeHeaderCollectionView];
    [self.likeHeaderCollectionView registerNib:[UINib nibWithNibName:@"HMSHomePageLikeHeaderImgCell" bundle:nil] forCellWithReuseIdentifier:@"HMSHomePageLikeHeaderImgCell"];
    
    self.likeHeaderCollectionViewRightLabel = [UILabel labelWithTitle:@"点了赞" Color:[UIColor darkGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
    [self.whiteBGView addSubview:self.likeHeaderCollectionViewRightLabel];
    
    self.likeHeaderCollectionViewDivider = [[UIView alloc]init];
    self.likeHeaderCollectionViewDivider.backgroundColor =HMSThemeDeviderColor;
    [self.whiteBGView addSubview:self.likeHeaderCollectionViewDivider];
    // UITableView
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.commentTableView.layer.cornerRadius = 3;
    self.commentTableView.clipsToBounds =YES;
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.commentTableView.bounces = NO;
    self.commentTableView.scrollEnabled = NO;
    self.commentTableView.showsVerticalScrollIndicator = NO;
    self.commentTableView.showsHorizontalScrollIndicator = NO;
    self.commentTableView.backgroundColor = [UIColor whiteColor];
    [self.whiteBGView addSubview:self.commentTableView];

    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints
{
    
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局子控件
//    self.divider.frame = CGRectMake(0, self.mh_height-MHGlobalBottomLineHeight, self.mh_width, MHGlobalBottomLineHeight);
    
}

/**
 *  浏览图片
 *
 */
- (void)clickImage:(UITapGestureRecognizer *)tap
{
    // 快速创建并进入浏览模式
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:tap.view.tag imageCount:self.weiboFrame.weibo.weibo_image.count datasource:self];
    
    // 设置长按手势弹出的地步ActionSheet数据,不实现此方法则没有长按手势
    [browser setActionSheetWithTitle:nil delegate:self cancelButtonTitle:@"取消" deleteButtonTitle:nil otherButtonTitles:@"保存图片",nil];
    
    // 自定义pageControl的一些属性
    browser.pageDotColor = [UIColor colorWithWhite:1 alpha:0.3]; ///< 此属性针对动画样式的pagecontrol无效
    browser.currentPageDotColor = [UIColor whiteColor];
    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;///< 修改底部pagecontrol的样式为系统样式,默认是弹性动画的样式
}

#pragma mark  -----------------tableVIewDelegate ---------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboFrame.weibo.comment.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMSHomePageCommentCell *cell = [HMSHomePageCommentCell cellWithTableView:tableView];
    
    cell.contentViewDevider.hidden =NO;
    cell.backgroundColor =UIColorFromRGB(0xf2f5f7);
    cell.commentFrame = self.weiboFrame.commentFrames[indexPath.row];
    cell.delegate = self;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row+1==self.weiboFrame.commentFrames.count) {
        cell.contentViewDevider.hidden =YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.weiboFrame.commentFrames[indexPath.row].cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)weiboCommentCell:(HMSHomePageCommentCell *)weiboCommentCell deleteComment:(HMSWeiboCommentModel *)comment
{
    NSIndexPath *indexPath = [self.commentTableView indexPathForCell:weiboCommentCell];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(topicCell:deleteRowAtIndexPath:commentM:)]) {
        [self.delegate topicCell:self deleteRowAtIndexPath:indexPath commentM:comment];
    }
}


#pragma mark  -----------------collectionViewDelegate ---------------------------

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.weiboFrame.weibo.praise.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMSHomePageLikeHeaderImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HMSHomePageLikeHeaderImgCell" forIndexPath:indexPath];
    cell.headerImg = self.weiboFrame.weibo.praise[indexPath.row];
    return cell;
}


#pragma mark    -   XLPhotoBrowserDatasource
//- (NSURL *)photoBrowser:(XLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    return [NSURL URLWithString:self.weiboFrame.weibo.weibo_image[index]];
//}
- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.pictureViewArray[index].image;
}

- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
    return self.pictureViewArray[index];
}
#pragma mark    -   XLPhotoBrowserDelegate

- (void)photoBrowser:(XLPhotoBrowser *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex
{
    // do something yourself
    switch (actionSheetindex) {
        
        case 0: // 保存
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
            break;
        default:
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
        }
            break;
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex==0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellDidClickedDelete:)]) {
            [self.delegate topicCellDidClickedDelete:self];
        }
    }else
    {
        
    }
}
-(void)deleteBtnAction:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除吗?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"删除",@"取消", nil];
    alert.tag = 1000;
    [alert show];
    
}

-(void)likeBtnClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellDidClickedLike:)]) {
        [self.delegate topicCellDidClickedLike:self];
    }
}

-(void)commentBtnClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellDidClickedComment:)]) {
        [self.delegate topicCellDidClickedComment:self];
    }
}

-(void)repeatBtnClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellDidClickedRepeat:)]) {
        [self.delegate topicCellDidClickedRepeat:self];
    }
}
@end

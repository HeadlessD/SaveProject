//
//  HMSHomePageCommentCell.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/20.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageCommentCell.h"
#import "HMSWeiboCommetFrame.h"
#import "HMSWeiboModel.h"
#import <UIImageView+WebCache.h>

@interface HMSHomePageCommentCell ()
@property (nonatomic,strong) UIImageView *headerImgView;

@property (nonatomic,strong) UILabel *nikeNameLabel;

@property (nonatomic,strong) UILabel *createTimeLabel;

@property (nonatomic,strong) UILabel *contentText;


@end
@implementation HMSHomePageCommentCell

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
    static NSString *ID = @"HMSHomePageCommentCell";
    HMSHomePageCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

-(void)setCommentFrame:(HMSWeiboCommetFrame *)commentFrame
{
    _commentFrame = commentFrame;
    HMSWeiboCommentModel *comment =commentFrame.weiboCommetnM;
    
    self.headerImgView.frame = commentFrame.avatarFrame;
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:comment.user_avatar] placeholderImage:[UIImage imageNamed:@"defaul_manHeaderImg"]];
    
    self.nikeNameLabel.frame = commentFrame.nikeNameFrame;
    self.nikeNameLabel.text = comment.user_name;
    
    self.createTimeLabel.frame = commentFrame.createTimeFrame;
    self.createTimeLabel.text = comment.time;
    
    self.contentText.frame = commentFrame.commentFrame;
    self.contentText.text = comment.content;
    
    self.contentViewDevider.frame = commentFrame.contentViewDeviderFrame;
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
    self.headerImgView = [[UIImageView alloc]init];
    self.headerImgView.image =[UIImage imageNamed:@"defaul_manHeaderImg"];
    self.headerImgView.layer.cornerRadius = 15;
    self.headerImgView.clipsToBounds = YES;
    [self.contentView addSubview:self.headerImgView];
    
    self.nikeNameLabel = [UILabel labelWithTitle:@"" Color:[UIColor blackColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.nikeNameLabel];
    
    self.createTimeLabel = [UILabel labelWithTitle:@"" Color:[UIColor lightGrayColor] Font:HMSFOND(11) textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.createTimeLabel];
    
    self.contentText = [UILabel labelWithTitle:@"" Color:[UIColor darkGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentLeft];
    self.contentText.numberOfLines = 0;
    [self.contentView addSubview:self.contentText];
    
    self.contentViewDevider =[[UIView alloc]init];
    self.contentViewDevider.backgroundColor = HMSThemeDeviderColor;
    [self.contentView addSubview:self.contentViewDevider];
    
   
   
    UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    longGestureRecognizer.allowableMovement = 2.5;
    [self addGestureRecognizer:longGestureRecognizer];

}


-(void)showMenu:(UIGestureRecognizer *)recognizer
{
    //HMSHomePageCommentCell *cell = (HMSHomePageCommentCell *)recognizer.view;
   
    
    if (recognizer.state == UIGestureRecognizerStateBegan){
        /*
        if(self.isFirstResponder){
            [self resignFirstResponder];
        }else{
            [self becomeFirstResponder];
        }
         */
        [self becomeFirstResponder];
        UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(delectAction:)];
        UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyAction:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        
        if (self.commentFrame.weiboCommetnM.is_delete) {
            menuController.menuItems = @[copyItem,deleteItem];
        }else
        {
            menuController.menuItems = @[copyItem];
        }
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
    }
    
}

-(void)delectAction:(id)sender
{
    //走代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(weiboCommentCell:deleteComment:)]) {
        [self.delegate weiboCommentCell:self deleteComment:self.commentFrame.weiboCommetnM];
    }
}



-(void)copyAction:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.commentFrame.weiboCommetnM.content;
    
}


#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints
{
    
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return action==@selector(delectAction:)||
    action==@selector(copyAction:);
}


@end

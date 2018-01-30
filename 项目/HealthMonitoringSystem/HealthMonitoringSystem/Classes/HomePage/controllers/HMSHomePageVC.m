//
//  HMSHomePageVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/13.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHomePageVC.h"
#import "HMSHomePageOldManCardTBCell.h"
#import "HMSHomePageOldManCollectionCell.h"
#import "HMSHomePageAddOldManCell.h"
#import "HMSSleepReportCell.h"
#import "HMSHomePageReleasePopView.h"
#import "HMSReleaseCircleOFFriendVC.h"
#import "HMSHomePageTopicCell.h"
#import "HMSWeiboModel.h"
#import "HMSWeiboFrame.h"
#import "HMSHomePageReplyInputView.h"
#import <MJRefresh.h>
#import "HMSSharePopView.h"
#import "HMSOldManModel.h"
#import "HMSInviteFriendVC.h"
#import "HMSOldManCardPopView.h"
#import "HMSHomePageInputInviteCodePopView.h"
#import "IQKeyboardManager.h"
#import "HMSTipsView.h"
#import "HMSHomePageCreateOldMPopView.h"
#import "HMSAddOldManVC.h"
#import "HMSHomePage_sleepReport.h"



/**  Cell边距 */
NSInteger const HMSHomepageWeiboOffset = 10;

@interface HMSHomePageVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HMSHomePageReplyInputViewDelegate,HMSHomePageTopicCellDelegate,HMSHomePageOldManCollectionCellDelegate>
@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) UITableView *homePageTableView;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray <HMSWeiboFrame *>*weiboFrameArray;

@property (nonatomic,copy)NSString *current_oldMan_id;
/** 评论框 */
@property (nonatomic , weak) HMSHomePageReplyInputView *inputView;

@property (nonatomic,copy)NSString *small_weibo_id_of_page;

@property (nonatomic,strong) NSMutableArray <HMSOldManModel *>*oldManArray;

@property (nonatomic,strong) HMSHomePage_sleepReport *sleep_report;
@end

@implementation HMSHomePageVC
{
    Boolean _isHiddenStatusBar;
    NSInteger _currentPage;
}
-(NSMutableArray<HMSOldManModel *> *)oldManArray
{
    if (!_oldManArray) {
        _oldManArray = [NSMutableArray array];
    }
    return _oldManArray;
}
-(NSMutableArray *)weiboFrameArray
{
    
    if (!_weiboFrameArray) {
        _weiboFrameArray = [NSMutableArray array];
    }
    return _weiboFrameArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshStatus:) name:@"HomePageStatusHiddenOrNO" object:nil];
    self.view.backgroundColor = HMSThemeBackgroundColor;
    
    [self initView];
    
    [self.homePageTableView.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    
}


-(void)initView
{
    UIImageView *backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,64+ 186)];
    backImageView.image = [UIImage imageNamed:@"homePage_banner"];
    [self.view addSubview:backImageView];
    
    self.topLabel =[UILabel labelWithTitle:@"老人信息" Color:[UIColor whiteColor] Font:iPhone5_5s?HMSFOND(18):HMSFOND(19) textAlignment:NSTextAlignmentCenter] ;
    self.topLabel.frame =CGRectMake(70, 20, KScreenWidth-140, 44);
    [self.view addSubview:self.topLabel];
    
    UIButton *leftBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"homePage_invite"] highLightImg:nil BGColor:nil clickAction:@selector(leftBtnClick:) viewController:self cornerRadius:0];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    leftBtn.frame = CGRectMake(8, 22, 50, 40);
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithImage:[UIImage imageNamed:@"homePage_release"] highLightImg:nil BGColor:nil clickAction:@selector(rightBtnClick:) viewController:self cornerRadius:0];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    rightBtn.frame = CGRectMake(KScreenWidth-40-8, 22, 50, 40);
    [self.view addSubview:rightBtn];
    
    self.homePageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64-49)];
    self.homePageTableView.backgroundColor =[UIColor clearColor];
    self.homePageTableView.delegate = self;
    self.homePageTableView.dataSource = self;
    self.homePageTableView.separatorStyle = NO;
    self.homePageTableView.showsVerticalScrollIndicator = NO;
    self.homePageTableView.contentInset = UIEdgeInsetsMake(0, 0, 6, 0);
    
    self.homePageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAllData)];
    self.homePageTableView.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWeiboData)];
    
    [self.homePageTableView registerClass:NSClassFromString(@"HMSHomePageOldManCardTBCell") forCellReuseIdentifier:@"HMSHomePageOldManCardTBCell"];
    [self.homePageTableView registerNib:[UINib nibWithNibName:@"HMSSleepReportCell" bundle:nil] forCellReuseIdentifier:@"HMSSleepReportCell"];
    [self.view addSubview:self.homePageTableView];
    
    
    
}


-(void)leftBtnClick:(UIButton *)btn
{
    WS(ws);
    HMSHomePageInputInviteCodePopView *inputView = [[HMSHomePageInputInviteCodePopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    inputView.popViewAciton = ^(NSString *code){
        NSLog(@"%@",code);
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"invitation_code"] =code;
        
        [SVProgressHUD show];
        [HMSNetWorkManager requestJsonDataWithPath:@"member/friend-and-relative-add-member-by-invitation-code" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            [SVProgressHUD dismiss];
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                
                HMSTipsView *inviteSuccess =  [[HMSTipsView alloc]initWithTitle:@"邀请码验证成功!" icon:[UIImage imageNamed:@"homepage_inviteSuccess"]];
                inviteSuccess.alpha = 0;
                [inviteSuccess showInView:[UIApplication sharedApplication].keyWindow];
                
                [UIView animateWithDuration:1.0 animations:^{
                    inviteSuccess.alpha = 1;
                    
                }completion:^(BOOL finished) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [inviteSuccess removeFromSuperview];
                        [ws loadAllOldManSuccess:^{
                            [ws.collectionView reloadData];
                        } failure:nil];
                    });
                }];
                
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    };
    [inputView show];
}

-(void)rightBtnClick:(UIButton *)btn
{
    WS(ws);
    HMSHomePageReleasePopView *popView =[[HMSHomePageReleasePopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    popView.popViewSelectAction = ^(NSInteger actionType){
        switch (actionType) {
            case 0:
            {
                [self openCamera];
            }
                break;
            case 1:
            {
                HMSReleaseCircleOFFriendVC *releaseVC = [[HMSReleaseCircleOFFriendVC alloc]init];
                releaseVC.controllerDismiss = ^{
                    [ws loadWeiboData];
                };
                releaseVC.releaseVCType = HMSReleaseCircleOFFriendVCImageText;
                [ws.navigationController pushViewController:releaseVC animated:YES];
            }
                break;
            case 2:
            {
                HMSReleaseCircleOFFriendVC *releaseVC = [[HMSReleaseCircleOFFriendVC alloc]init];
                releaseVC.controllerDismiss = ^{
                     [ws loadWeiboData];
                };
                releaseVC.releaseVCType = HMSReleaseCircleOFFriendVCText;
                [ws.navigationController pushViewController:releaseVC animated:YES];
            }
                break;
                
            default:
                break;
        }
       
    };
    [popView show];
}

/**
 * 打开照相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    //self.pickerVC = ipc;
//    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)loadAllData
{
    WS(ws);
    [self loadAllOldManSuccess:^{
        [ws.collectionView reloadData];
        NSString *oldMan_id =[ws.oldManArray firstObject].oldMan_id;
        if (oldMan_id.length<=0) {
            return ;
        }
        ws.current_oldMan_id =oldMan_id;
        [ws loadReportWithOldMan_id:ws.current_oldMan_id Success:^{
            [ws.homePageTableView reloadData];
        } failure:nil];
        
        [ws loadWeiboData];
    } failure:nil];

    
}
-(void)loadAllOldManSuccess:(void (^)(void))success failure:(void (^)(void))failure
{
    [self.oldManArray removeAllObjects];
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"member/get-user-member" withParams:nil withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            self.oldManArray = [HMSOldManModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"]];
            if (success) {
                success();
            }
        }else
        {
            if (failure) {
                failure();
            }
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

-(void)loadReportWithOldMan_id:(NSString *)oldMan_id Success:(void (^)(void))success failure:(void (^)(void))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"member_id"]=oldMan_id;
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"report/get-basic-report" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            self.sleep_report = [HMSHomePage_sleepReport mj_objectWithKeyValues:respondObj[@"data"]];
            if (success) {
                success();
            }
        }else
        {
            if (failure) {
                failure();
            }
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

-(void)loadWeiboData
{
    
    [self.homePageTableView.mj_footer endRefreshing];
    [self.weiboFrameArray removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    _currentPage = 1;
    params[@"page"] =@(_currentPage);
    params[@"offset"] =@(HMSHomepageWeiboOffset);
    params[@"small_weibo_id_of_page"]=@"";
    params[@"member_id"]=self.current_oldMan_id;
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/get-circle-of-friends" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            NSArray *tempArray = [HMSWeiboModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"][@"list"]];
            self.small_weibo_id_of_page =respondObj[@"data"][@"small_weibo_id_of_page"];
            
            for (HMSWeiboModel *weibo in tempArray) {
                [self.weiboFrameArray addObject:[self _weiboFrameWithWeibo:weibo]];
            }
            
            [self.homePageTableView reloadData];
         
            NSInteger allWeibo =[respondObj[@"data"][@"pager"][@"allWeibo"] integerValue];
            if (self.weiboFrameArray.count >=allWeibo) {
                 [self.homePageTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
        
        [self.homePageTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        [self.homePageTableView.mj_header endRefreshing];
    }];
}

-(void)loadMoreWeiboData
{
    [self.homePageTableView.mj_header endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] =@(_currentPage+1);
    params[@"offset"] =@(HMSHomepageWeiboOffset);
    params[@"small_weibo_id_of_page"]=self.small_weibo_id_of_page;
    params[@"member_id"]=self.current_oldMan_id;
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/get-circle-of-friends" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
           
            NSArray *tempArray = [HMSWeiboModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"][@"list"]];
            self.small_weibo_id_of_page =respondObj[@"data"][@"small_weibo_id_of_page"];
            
            for (HMSWeiboModel *weibo in tempArray) {
                [self.weiboFrameArray addObject:[self _weiboFrameWithWeibo:weibo]];
            }
            [self.homePageTableView reloadData];
            NSInteger allWeibo =[respondObj[@"data"][@"pager"][@"allWeibo"] integerValue];
            if (self.weiboFrameArray.count >=allWeibo) {
                [self.homePageTableView.mj_footer endRefreshing];
                [self.homePageTableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
             _currentPage++;
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
        [self.homePageTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        [self.homePageTableView.mj_footer endRefreshing];
    }];
}

/** 评论回复 */
- (void)_replyCommentWithIndexPath:(NSIndexPath *)indexPath commentReply:(HMSWeiboModel *)weiboM
{
    // 显示
    HMSHomePageReplyInputView *replyInputView = [HMSHomePageReplyInputView replyInputView];
    replyInputView.weiboM = weiboM;
    replyInputView.indexPath = indexPath;
    replyInputView.delegate = self;
    [replyInputView show];
    
    self.inputView = replyInputView;
}

#pragma mark - 辅助方法
/** topic --- topicFrame */
- (HMSWeiboFrame *)_weiboFrameWithWeibo:(HMSWeiboModel *)weibo
{
    HMSWeiboFrame *weiboFrame = [[HMSWeiboFrame alloc] init];
    // 传递微博模型数据，计算所有子控件的frame
    weiboFrame.weibo = weibo;
    
    return weiboFrame;
}

#pragma mark - MHYouKuInputPanelViewDelegate
- (void) inputPanelView:(HMSHomePageReplyInputView *)inputView attributedText:(NSString *)attributedText
{
    WS(ws);
    NSIndexPath *indexPath = inputView.indexPath;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"weibo_id"] =inputView.weiboM.weibo_id;
    params[@"author_id"] =inputView.weiboM.weibo_author_id;
    params[@"content"] =attributedText;
    params[@"parent_id"] =@"";
    
    [SVProgressHUD show];
    
    NSArray *tempArray = self.weiboFrameArray[indexPath.row].weibo.comment;
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/comment" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            HMSWeiboCommentModel *commentM = [[HMSWeiboCommentModel alloc]initWithComment_id:respondObj[@"data"][@"comment_id"] user_id:[HMSAccount shareAccount].user_id user_name:[HMSAccount shareAccount].username user_avatar:[HMSAccount shareAccount].avatar time:@"刚刚" content:attributedText is_delete:YES];
            NSMutableArray *tempMArray = [NSMutableArray arrayWithArray:tempArray];
            [tempMArray addObject:commentM];
            ws.weiboFrameArray[indexPath.row].weibo.comment =tempMArray;
            HMSWeiboModel *weiboM = ws.weiboFrameArray[indexPath.row].weibo;
            HMSWeiboFrame *weiboFrame =[self _weiboFrameWithWeibo:weiboM];
            ws.weiboFrameArray[indexPath.row] =weiboFrame;
            [ws.homePageTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}
#pragma mark -------------- HMSHomePageTopicCellDelegate------------------
-(void)topicCellDidClickedRepeat:(HMSHomePageTopicCell *)topicCell
{
    HMSSharePopView *sharePopView = [[HMSSharePopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [sharePopView show];
    sharePopView.popViewSelectAction = ^(NSInteger tag){
        
#warning 分享朋友圈点击之后逻辑
    };
}
-(void)topicCellDidClickedComment:(HMSHomePageTopicCell *)topicCell
{
    NSIndexPath *indexPath = [self.homePageTableView indexPathForCell:topicCell];
    [self _replyCommentWithIndexPath:indexPath commentReply:topicCell.weiboFrame.weibo];
}
-(void)topicCellDidClickedDelete:(HMSHomePageTopicCell *)topicCell
{
    WS(ws);
   NSIndexPath *indexPath = [self.homePageTableView indexPathForCell:topicCell];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"weibo_id"] =topicCell.weiboFrame.weibo.weibo_id;
    
    [SVProgressHUD show];
    
    
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/delete-weibo" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            
             [self.weiboFrameArray removeObjectAtIndex:indexPath.row];
            [ws.homePageTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
           
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}
-(void)topicCellDidClickedLike:(HMSHomePageTopicCell *)topicCell
{
    WS(ws);
    NSIndexPath *indexPath = [self.homePageTableView indexPathForCell:topicCell];
    
    if (self.weiboFrameArray[indexPath.row].weibo.is_praise) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"weibo_id"] =topicCell.weiboFrame.weibo.weibo_id;
        
        NSArray *tempArray = self.weiboFrameArray[indexPath.row].weibo.praise;
        
        [SVProgressHUD show];
        [HMSNetWorkManager requestJsonDataWithPath:@"weibo/delete-praise" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            [SVProgressHUD dismiss];
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                NSMutableArray *tempMArray = [NSMutableArray arrayWithArray:tempArray];
                [tempMArray removeObject:[HMSAccount shareAccount].avatar];
                
                ws.weiboFrameArray[indexPath.row].weibo.praise =tempMArray;
                HMSWeiboModel *weiboM = ws.weiboFrameArray[indexPath.row].weibo;
                weiboM.is_praise =NO;
                HMSWeiboFrame *weiboFrame =[self _weiboFrameWithWeibo:weiboM];
                ws.weiboFrameArray[indexPath.row] =weiboFrame;
                [ws.homePageTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    }else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"weibo_id"] =topicCell.weiboFrame.weibo.weibo_id;
        params[@"author_id"] =topicCell.weiboFrame.weibo.weibo_author_id;
        
        
        
        NSArray *tempArray = self.weiboFrameArray[indexPath.row].weibo.praise;
        
        [SVProgressHUD show];
        [HMSNetWorkManager requestJsonDataWithPath:@"weibo/praise" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
            [SVProgressHUD dismiss];
            NSString *error = [respondObj objectForKey:@"error"];
            NSString *error_message = [respondObj objectForKey:@"error_message"];
            if([error isEqualToString:@""]){
                NSMutableArray *tempMArray = [NSMutableArray arrayWithArray:tempArray];
                [tempMArray addObject:[HMSAccount shareAccount].avatar];
                ws.weiboFrameArray[indexPath.row].weibo.praise =tempMArray;
                HMSWeiboModel *weiboM = ws.weiboFrameArray[indexPath.row].weibo;
                weiboM.is_praise =YES;
                HMSWeiboFrame *weiboFrame =[self _weiboFrameWithWeibo:weiboM];
                ws.weiboFrameArray[indexPath.row] =weiboFrame;
                [ws.homePageTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:error_message];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        }];
    }
}

-(void)topicCell:(HMSHomePageTopicCell *)topicCell deleteRowAtIndexPath:(NSIndexPath *)indexPath commentM:(HMSWeiboCommentModel *)comment
{
    WS(ws);
    NSIndexPath *cellIndexPath = [self.homePageTableView indexPathForCell:topicCell];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"comment_id"] =comment.comment_id;
    
    NSArray *tempArray = self.weiboFrameArray[cellIndexPath.row].weibo.comment;
    
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/delete-comment" withParams:params withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            NSMutableArray *tempMArray = [NSMutableArray arrayWithArray:tempArray];
            [tempMArray removeObjectAtIndex:indexPath.row];
            ws.weiboFrameArray[cellIndexPath.row].weibo.comment =tempMArray;
            
            HMSWeiboModel *weiboM = ws.weiboFrameArray[cellIndexPath.row].weibo;
            HMSWeiboFrame *weiboFrame =[self _weiboFrameWithWeibo:weiboM];
            ws.weiboFrameArray[cellIndexPath.row] =weiboFrame;
            [ws.homePageTableView reloadRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

#pragma mark -------------------------- UIImagePickerControllerDelegate-------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    WS(ws);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    HMSReleaseCircleOFFriendVC *releaseVC = [[HMSReleaseCircleOFFriendVC alloc]init];
    releaseVC.controllerDismiss = ^{
         [ws loadWeiboData];
    };
    releaseVC.releaseVCType = HMSReleaseCircleOFFriendVCImageText;
    releaseVC.typeOneImg = image;
    [self.navigationController pushViewController:releaseVC animated:YES];
}

#pragma mark  ---------------------UITableViewDataSource-----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return self.weiboFrameArray.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HMSHomePageOldManCardTBCell *cell = (HMSHomePageOldManCardTBCell *)[tableView dequeueReusableCellWithIdentifier:@"HMSHomePageOldManCardTBCell"];
        cell.backgroundColor =HMSThemeBackgroundColor;
        //cell = [[HMSHomePageOldManCardTBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HMSHomePageAddOldManCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.collectionView = cell.collectionView;
        self.collectionView.delegate =self;
        self.collectionView.dataSource = self;
        [self.collectionView reloadData];
        return cell;
    }else if (indexPath.section==1)
    {
        HMSSleepReportCell *cell = (HMSSleepReportCell *)[tableView dequeueReusableCellWithIdentifier:@"HMSSleepReportCell"];
        cell.backgroundColor =HMSThemeBackgroundColor;
        cell.sleep_report = self.sleep_report;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        HMSHomePageTopicCell *cell = [HMSHomePageTopicCell cellWithTableView:tableView];
        cell.backgroundColor =HMSThemeBackgroundColor;
        cell.weiboFrame = self.weiboFrameArray[indexPath.row];
        cell.delegate =self;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 192;
        }
            break;
        case 1:
        {
            return 291;
        }
            break;
        case 2:
        {
            return  self.weiboFrameArray[indexPath.row].height;
            
        }
            break;
            
        default:
            break;
    }
    return 0;
}


#pragma mark ---------------- UICollectionViewDelegate,DataSource---------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return self.oldManArray.count;
    }else
    {
        return 1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HMSHomePageOldManCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HMSHomePageOldManCollectionCell" forIndexPath:indexPath];
        cell.delegate =self;
        cell.oldManM = self.oldManArray[indexPath.row];
        return cell;
    }else {
        HMSHomePageAddOldManCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HMSHomePageAddOldManCell" forIndexPath:indexPath];
        return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.section == 0) {
        HMSOldManModel *oldMan = self.oldManArray[indexPath.row];
        self.current_oldMan_id = oldMan.oldMan_id;
        [ws loadReportWithOldMan_id:oldMan.oldMan_id Success:^{
            [ws.homePageTableView reloadData];
        } failure:nil];
        [self loadWeiboData];
    }else{
        HMSHomePageCreateOldMPopView *addOldManView = [[HMSHomePageCreateOldMPopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        addOldManView.popViewAction = ^(NSString *phoneNum){
            if ([phoneNum isEqualToString:@""]) {
                HMSAddOldManVC *addOldManVC = [[HMSAddOldManVC alloc]init];
                addOldManVC.controllerDismiss = ^{
                    [ws loadAllOldManSuccess:^{
                        [ws.collectionView reloadData];
                    } failure:nil];
                };
                [ws.navigationController pushViewController:addOldManVC animated:YES];
            }else
            {
                
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"mobile"] =phoneNum;
                
                [SVProgressHUD show];
                [HMSNetWorkManager requestJsonDataWithPath:@"member/pull-member-web-by-mobile" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
                    [SVProgressHUD dismiss];
                    NSString *error = [respondObj objectForKey:@"error"];
                    NSString *error_message = [respondObj objectForKey:@"error_message"];
                    if([error isEqualToString:@""]){
                        HMSOldManModel *oldManModel = [HMSOldManModel mj_objectWithKeyValues:respondObj[@"data"]];
                        
                        HMSAddOldManVC *addOldManVC = [[HMSAddOldManVC alloc]init];
                        addOldManVC.oldMan =oldManModel;
                        addOldManVC.controllerDismiss = ^{
                            [ws loadAllOldManSuccess:^{
                                [ws.collectionView reloadData];
                            } failure:nil];
                        };
                        [ws.navigationController pushViewController:addOldManVC animated:YES];
                        
                    }else{
                        [SVProgressHUD showErrorWithStatus:error_message];
                    }
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
                }];
                
            }
        };
        [addOldManView show];
        
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(290, 120);
    }else if(indexPath.section==1)
    {
        return CGSizeMake(50, 120);
    }
    return CGSizeZero;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

-(void)oldManCardCellDidClickHeaderImg:(HMSHomePageOldManCollectionCell *)oldManCardCell addFriend:(HMSOldManModel *)oldMan
{
    WS(ws);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"member_id"] = oldMan.oldMan_id;
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"member/get-member-info" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            HMSOldManModel *oldManModel = [HMSOldManModel mj_objectWithKeyValues:respondObj[@"data"]];
            HMSOldManCardPopView *oldManCardPopView = [[HMSOldManCardPopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) oldManModel:oldManModel];
            oldManCardPopView.inviteBtnClick =^(NSString *oldMan_id){
                HMSInviteFriendVC *inviteFVC = [[HMSInviteFriendVC alloc]init];
                inviteFVC.oldManID = oldMan.oldMan_id;
                [ws.navigationController pushViewController:inviteFVC animated:YES];
            };
            [oldManCardPopView show];
            
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}
-(void)oldManCardCellDidClickInviteBtn:(HMSHomePageOldManCollectionCell *)oldManCardCell addFriend:(HMSOldManModel *)oldMan
{
    HMSInviteFriendVC *inviteFVC = [[HMSInviteFriendVC alloc]init];
    inviteFVC.oldManID = oldMan.oldMan_id;
    [self.navigationController pushViewController:inviteFVC animated:YES];
}



- (BOOL)prefersStatusBarHidden{

    return _isHiddenStatusBar;
}
-(void)refreshStatus:(NSNotification *)notification
{
    NSDictionary *dict = [notification object];
    _isHiddenStatusBar = [dict[@"hidden"] boolValue];
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

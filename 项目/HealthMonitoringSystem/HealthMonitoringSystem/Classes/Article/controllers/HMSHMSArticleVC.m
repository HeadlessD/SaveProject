//
//  HMSHMSArticleVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/4.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSHMSArticleVC.h"
#import <MJRefresh.h>
#import "HMSArticleModel.h"
#import "MLInformationTwoCell.h"
#import "HMSArticleWebVC.h"

@interface HMSHMSArticleVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *articleTableView;

@property (nonatomic,copy)NSMutableArray<HMSArticleModel *> *dataSource;

@property (nonatomic,assign)NSInteger pageIndex;

@property (nonatomic,strong)NSNumber *pushIndex;

//@property(nonatomic,strong) MLDayReportModel *dayModel;
//
//@property(nonatomic,strong) MLDaySubReportModel *daySubReportModel;

@end

@implementation HMSHMSArticleVC
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}


-(void)initView
{
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49)];
    [tableView registerNib:[UINib nibWithNibName:@"MLInformationOneCell" bundle:nil] forCellReuseIdentifier:@"MLInformationOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"MLInformationTwoCell" bundle:nil] forCellReuseIdentifier:@"MLInformationTwoCell"];
    tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    tableView.dataSource =self;
    tableView.delegate =self;
    tableView.showsVerticalScrollIndicator =NO;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    tableView.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.articleTableView =tableView;
    [self.view addSubview:tableView];
    
    [tableView.mj_header beginRefreshing];
}

-(void)loadData
{
    [self.articleTableView.mj_footer endRefreshing];
    [self.dataSource removeAllObjects];
//    self.dayModel = nil;
//    self.daySubReportModel = nil;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.pageIndex = 1;
    params[@"page"] =@(self.pageIndex);
    [SVProgressHUD show];
    
    [HMSNetWorkManager requestJsonDataWithPath:@"article/get-list" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
           
            NSArray *tempArr = [HMSArticleModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"]];
            [self.dataSource addObjectsFromArray:tempArr];
            [SVProgressHUD dismiss];
            
            if (tempArr.count<10) {
                [self.articleTableView.mj_header endRefreshing];
                [self.articleTableView reloadData];
                [self.articleTableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            
        }else{
            [self.dataSource removeAllObjects];
            [SVProgressHUD showErrorWithStatus:error_message];
        }
        [self.articleTableView.mj_header endRefreshing];
        [self.articleTableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        [self.articleTableView.mj_header endRefreshing];
    }];
    
    
}
-(void)loadMoreData
{
    [self.articleTableView.mj_header endRefreshing];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] =@(self.pageIndex+1);
    [SVProgressHUD showWithStatus:@"加载中..."];
    [HMSNetWorkManager requestJsonDataWithPath:@"article/get-list" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            
            NSArray *tempArr = [HMSArticleModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"]];
            [self.dataSource addObjectsFromArray:tempArr];
            self.pageIndex ++;
            [SVProgressHUD dismiss];
            if (tempArr.count<10) {
                [self.articleTableView.mj_footer endRefreshingWithNoMoreData];
                [self.articleTableView reloadData];
                
                //                [self.informationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                return ;
            }
            
        }else{
            [self.dataSource removeAllObjects];
            [SVProgressHUD showErrorWithStatus:error_message];
        }
        [self.articleTableView.mj_footer endRefreshing];
        [self.articleTableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        [self.articleTableView.mj_footer endRefreshing];
    }];
    
    
}


#pragma  mark  ------------------tableViewDelegate--------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLInformationTwoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MLInformationTwoCell"];
    cell.articlModel = self.dataSource[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200*HMS_ScreenScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HMSArticleWebVC *webViewVC =[[HMSArticleWebVC alloc]init];
    webViewVC.articleModel =self.dataSource[indexPath.row];
   
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end

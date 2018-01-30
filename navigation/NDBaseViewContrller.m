//
//  NDBaseViewContrller.m
//  NextDoor
//
//  Created by 罗艺 on 2017/3/22.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import "NDBaseViewContrller.h"
#import <MJRefresh/MJRefresh.h>


@interface NDBaseViewContrller ()

@end

@implementation NDBaseViewContrller

//-(NdNoFavDataView *)nodataView{
//    if (_nodataView==nil) {
//        _nodataView=[NdNoFavDataView viewFromXib];
//        _nodataView.frame=self.view.bounds;
//        [self.view addSubview:_nodataView];
//    }
//
//    if (self.baseDataSource.count) {
//        _nodataView.hidden=YES;
//    }else{
//        _nodataView.hidden=NO;
//    }
//
//    return _nodataView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  self.pageIdx=1;
}

-(NSMutableArray *)baseDataSource{
    if (_baseDataSource==nil) {
        _baseDataSource=[NSMutableArray array];
    }
    return _baseDataSource;
}


-(void)initScrollerView{
    self.baseScrollerView.mj_header=[MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshByHeader)];
    
    [self.baseScrollerView.mj_header beginRefreshing];
}

-(void)InitRfreshView{
    self.baseTableView.mj_header=[MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshByHeader)];
   
    if (self.notAutoRefresh==NO) {
         [self beginRefreshingHeader];
    }
   
}

-(void)beginRefreshingHeader{
    [self.baseTableView.mj_header beginRefreshing];
}

-(void)initTableFooter{
    if (self.baseDataSource.count>5) {
        
    }
}

-(void)InitCollViewRfreshView{
    self.baseCollctionView.mj_header=[MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshByHeader)];
//    self.baseCollctionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshByFooter)];
  // [self.baseTableView.mj_header beginRefreshing];
}

-(void)refreshByHeader{
    self.pageIdx=1;
    [self.baseDataSource removeAllObjects];
}
-(void)stopRefreshHeader{
    if (self.baseTableView) {
        [self.baseTableView.mj_header endRefreshing];
    }else if(self.baseCollctionView){
     [self.baseCollctionView.mj_header endRefreshing];
    }else{
     [self.baseScrollerView.mj_header endRefreshing];
    }
    
}


-(void)refreshByFooter{
   self.pageIdx++;
}

-(void)stopRefreshFooter{
    if (self.baseTableView) {
        [self.baseTableView.mj_footer endRefreshing];
    }else{
        [self.baseCollctionView.mj_footer endRefreshing];
}}

-(void)loadLocalDataForTest{
    [self stopRefreshFooter];
    [self stopRefreshHeader];
    NSArray*arr=@[@"1",@"1",@"1"];
    if (self.baseDataSource.count<8) {
         [self addEntryFormArr:arr];
    }else{
        [self addEntryFormArr:nil];
    }
   
    
}

-(void)loadedDatas{
    [self stopRefreshFooter];
    [self stopRefreshHeader];
    if (self.baseCollctionView) {
        [self.baseCollctionView reloadData];
    }else{
        [self.baseTableView reloadData];
    }

}


-(void)addEntryFormArr:(NSArray*)arr{
    if (arr&&arr.count) {
        [self.baseDataSource addObjectsFromArray:arr];
        if (!self.baseTableView.mj_footer) {
             self.baseTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshByFooter)];
        }
        [self loadedDatas];
    }else{
        if (!self.baseDataSource.count) {
            [self.baseTableView reloadData];
        }       
        [self stopRefreshHeader];
        [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
    
    }
}

@end

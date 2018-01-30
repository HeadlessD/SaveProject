//
//  NDBaseViewContrller.h
//  NextDoor
//
//  Created by 罗艺 on 2017/3/22.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDBaseViewContrller : UIViewController
-(void)refreshByHeader;
-(void)stopRefreshHeader;
-(void)refreshByFooter;
-(void)stopRefreshFooter;
-(void)InitRfreshView;
-(void)loadLocalDataForTest;
-(void)InitCollViewRfreshView;
-(void)loadedDatas;
-(void)addEntryFormArr:(NSArray*)arr;
-(void)initScrollerView;
-(void)beginRefreshingHeader;
@property(nonatomic,weak)UITableView* baseTableView;
@property(nonatomic,weak)UICollectionView* baseCollctionView;
@property(nonatomic,weak)UIScrollView* baseScrollerView;
@property(nonatomic,assign)NSInteger pageIdx;
@property(nonatomic,strong)NSMutableArray*baseDataSource;
@property(nonatomic,assign)BOOL notAutoRefresh;
//@property(nonatomic,strong)NdNoFavDataView*nodataView;
@end

//
//  HMSMyOldManVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMyOldManVC.h"
#import "HMSMyOldManCell.h"
#import "HMSMyOldManAddMan.h"
#import "HMSOldManModel.h"
#import "HMSAddOldManVC.h"
#import "HMSEditOldManVC.h"

@interface HMSMyOldManVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) UIActivityIndicatorView* activityIndicatorView;

@property (nonatomic,strong) NSMutableArray <HMSOldManModel *>*myOldManArray;
@end

@implementation HMSMyOldManVC
-(NSMutableArray *)myOldManArray
{
    if (!_myOldManArray) {
        _myOldManArray = [NSMutableArray array];
        
    }
    return _myOldManArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self loadAllOldMan];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HMSThemeBackgroundColor;
    
    [self initView];
}

-(void)loadAllOldMan
{
    [self.myOldManArray removeAllObjects];
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"member/get-user-member" withParams:nil withMethodType:HttpRequestTypePost success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            self.myOldManArray = [HMSOldManModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"]];
            [self.collectionView reloadData];
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

-(void)initView
{
    self.topLabel =[UILabel labelWithTitle:@"我的老人" Color:HMSThemeColor Font:iPhone5_5s?HMSFOND(18):HMSFOND(19) textAlignment:NSTextAlignmentCenter] ;
    self.topLabel.frame =CGRectMake(70, 20, KScreenWidth-140, 44);
    [self.view addSubview:self.topLabel];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setFrame:CGRectMake(8, 17, 50, 50)];
    [self.backBtn setImage:[[UIImage imageNamed:@"navigationBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    CGFloat minimumLineWidth = (KScreenWidth-180)/3;
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionViewFlowLayout.itemSize = CGSizeMake(90, 130);
    self.collectionViewFlowLayout.minimumLineSpacing = 30;
    self.collectionViewFlowLayout.minimumInteritemSpacing = minimumLineWidth;
    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(30, minimumLineWidth-1, 0, minimumLineWidth-1);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, self.view.height-64) collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsHorizontalScrollIndicator =NO;
    self.collectionView.backgroundColor = [UIColor clearColor];    //加载控件
//    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(KScreenWidth / 2, 40, 10, 10)];
//    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    [self.activityIndicatorView startAnimating];
//    [self.collectionView addSubview:self.activityIndicatorView];
    //[self.collectionView registerClass:[MLUserSettingCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMSMyOldManCell" bundle:nil] forCellWithReuseIdentifier:@"HMSMyOldManCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMSMyOldManAddMan" bundle:nil] forCellWithReuseIdentifier:@"HMSMyOldManAddMan"];
    
    [self.view addSubview:self.collectionView];
    
}


-(void)backBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---------------- UICollectionViewDelegate,DataSource---------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        
        return self.myOldManArray.count;
    }else
    {
         return 1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HMSMyOldManCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HMSMyOldManCell" forIndexPath:indexPath];
        cell.oldManM = self.myOldManArray[indexPath.row];
      
        return cell;
    }else {
        HMSMyOldManAddMan *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HMSMyOldManAddMan" forIndexPath:indexPath];
        return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HMSOldManModel *oldMan = self.myOldManArray[indexPath.row];
        
        if ([oldMan.user_id isEqualToString:[HMSAccount shareAccount].user_id]) {
            HMSEditOldManVC *editOldManVC = [[HMSEditOldManVC alloc]init];
            editOldManVC.member_id = oldMan.oldMan_id;
            
            [self.navigationController pushViewController:editOldManVC animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"非当前用户创建老人，不可编辑"];
        }
        
    }else{
        HMSAddOldManVC *createOldManVC  = [[HMSAddOldManVC alloc]init];
        [self.navigationController pushViewController:createOldManVC animated:YES];
    }
    
    
}

@end

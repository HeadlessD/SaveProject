//
//  HMSSelectAddressVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/18.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSelectAddressVC.h"
#import <CoreLocation/CoreLocation.h>
#import "HMSAddressModel.h"

@interface HMSSelectAddressVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong)NSArray<HMSAddressModel *> *addressArray;
@end

@implementation HMSSelectAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HMSThemeBackgroundColor;
    self.title = @"所在位置";
    
    [self initializeLocationService];
    [self initView];
}



-(void)initView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, KScreenWidth, KScreenHeight-65)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
}


#pragma mark  ----------------UITableViewDelegate---------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.addressArray.count>0) {
        return self.addressArray.count+1;
    }else
    {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell"];;
    
    if (indexPath.row==0) {
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OneCell"];
            cell.textLabel.font = HMSFOND(16);
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, cell.height-0.5, KScreenWidth-8, 0.5)];
            lineView.backgroundColor =HMSThemeBackgroundColor;
            [cell.contentView addSubview:lineView];
        }
        cell.textLabel.text =@"不显示位置";
        cell.textLabel.textColor = HMSThemeColor;
        if (!self.currentAddress) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
        {
            cell.accessoryType =UITableViewCellAccessoryNone;
        }
        return cell;
    }else if (indexPath.row==1)
    {
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OneCell"];
            cell.textLabel.font = HMSFOND(16);
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, cell.height-0.5, KScreenWidth-8, 0.5)];
            lineView.backgroundColor =HMSThemeBackgroundColor;
            [cell.contentView addSubview:lineView];
        }
        cell.textLabel.text =self.addressArray[indexPath.row-1].name;
        cell.textLabel.textColor = [UIColor blackColor];
    }else
    {
        cell =[tableView dequeueReusableCellWithIdentifier:@"TwoCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TwoCell"];
            cell.textLabel.font = HMSFOND(16);
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, cell.height-0.5, KScreenWidth-8, 0.5)];
            lineView.backgroundColor =HMSThemeBackgroundColor;
            [cell.contentView addSubview:lineView];
            
        }
         cell.textLabel.text =self.addressArray[indexPath.row-1].name;
        cell.detailTextLabel.text =self.addressArray[indexPath.row-1].location;
    }
    if (self.currentAddress && [self.currentAddress isEqualToString:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if(!self.currentAddress &&[cell.textLabel.text isEqualToString:@"不显示位置"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        if (self.selectAddress) {
            self.selectAddress(nil);
        }
    }else if(indexPath.row==1)
    {
        if (self.selectAddress) {
            self.selectAddress(self.addressArray[indexPath.row-1].name);
        }
    }else
    {
        NSString *address = [NSString stringWithFormat:@"%@·%@",self.addressArray[0].name,self.addressArray[indexPath.row-1].name];
        if (self.selectAddress) {
            self.selectAddress(address);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)initializeLocationService {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    // 取得定位权限，有两个方法，取决于你的定位使用情况
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [_locationManager requestWhenInUseAuthorization];//这句话ios8以上版本使用。
    [_locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //    //将经度显示到label上
        NSString *longitude = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //    //将纬度现实到label上
        NSString *latitude = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    
    [self getPOIWithLongitude:longitude andLatitude:latitude];
    
    [manager stopUpdatingLocation];
}

-(void)getPOIWithLongitude:(NSString *)longitude andLatitude:(NSString *)latitude
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lng"] =longitude;
    params[@"lat"] =latitude;
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"weibo/get-baidu-map" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            self.addressArray = [HMSAddressModel mj_objectArrayWithKeyValuesArray:respondObj[@"data"]];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}


@end

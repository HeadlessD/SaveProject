//
//  HMSMonitorVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/25.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSMonitorVC.h"
#import "HMSHomePageOldManCollectionCell.h"
#import "HMSOldManModel.h"
#import "HMSMonitorRealTimeView.h"
#import "HMSDateSelectView.h"
#import "HMSMonitorDayReportOneView.h"
#import "HMSMonitorSleepProportionView.h"
#import "HMSMonitorCycleView.h"
#import "WYLineChartView.h"
#import "HMSDayReportModel.h"
#import "WYLineChartPoint.h"
#import "HMSMonthReportModel.h"
#import "HMSSharePopView.h"
#import "HMSSleepSubsectionView.h"



@interface HMSMonitorVC ()<UICollectionViewDelegate,UICollectionViewDataSource,HMSDateSelectViewDelegate,WYLineChartViewDatasource,WYLineChartViewDelegate>
@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIScrollView *contentView;

@property (nonatomic,strong) UIView *garyBGView;

@property (nonatomic,strong) HMSMonitorRealTimeView *realTimeView;

@property (nonatomic,strong) HMSDateSelectView *dateSelectView;

@property (nonatomic,strong) HMSMonitorDayReportOneView *dayReportOneViwe;

@property (nonatomic,strong) HMSMonitorCycleView *cycleView;

@property (nonatomic,strong) HMSSleepSubsectionView *sleepSubsectionView;

@property (nonatomic,strong) UIView *dayReportView;

@property (nonatomic,strong) UIView *monthReportView;

@property (nonatomic,strong) WYLineChartView *heartRateChartView;

@property (nonatomic,strong) UILabel *heartRateLabel;


@property (nonatomic,strong) UILabel *breathRateLabel;

@property (nonatomic,strong) WYLineChartView *breathRateChartView;


@property (nonatomic,strong) UILabel *bodyMoveLabel;

@property (nonatomic,strong) WYLineChartView *bodyMoveChartView;
//月报图表View
@property (nonatomic,strong) WYLineChartView *monthChartView;

@property (nonatomic,strong) UILabel *avgDeepSleep;

@property (nonatomic,strong) UILabel *bestSleepTitle;

@property (nonatomic,strong) UILabel *bestSleep;

@property (nonatomic,strong) NSMutableArray <HMSOldManModel *>*oldManArray;

@property (nonatomic,copy) NSString *currentOldManID;

@property (nonatomic,copy) NSString *currentDayStr;

@property (nonatomic,copy) NSString *currentMonthStr;

@property (nonatomic,strong) HMSDayReportModel *currentDayReport;

@property (nonatomic,strong) HMSMonthReportModel *currentMonthReport;


/** 心率数据*/
@property(nonatomic,strong) NSMutableArray *heartBeartDataArray;
/** 心率改变后数据*/
@property (nonatomic, strong) NSArray *heartBeartChangeDataArray;
/** 心率图时间轴*/
@property(nonatomic,strong) NSMutableArray *heartBeartTimeArray;
/** 心率图Y轴数据*/
@property (nonatomic, strong) NSArray *heartBeartYPoint;

/** 呼吸数据*/
@property(nonatomic,strong) NSMutableArray *breathDataArray;
/** 呼吸改变后数据*/
@property (nonatomic, strong) NSArray *breathChangeDataArray;
/** 呼吸图时间轴*/
@property(nonatomic,strong) NSMutableArray *breathTimeArray;
/** 呼吸图Y轴数据*/
@property (nonatomic, strong) NSArray *breathYPoint;

/** 体动数据*/
@property(nonatomic,strong) NSMutableArray *bodyMoveDataArray;
/** 体动改变后数据*/
@property (nonatomic, strong) NSArray *bodyMoveChangeDataArray;
/** 体动图时间轴*/
@property(nonatomic,strong) NSMutableArray *bodyMoveTimeArray;
/** 体动图Y轴数据*/
@property (nonatomic, strong) NSArray *bodyMoveYPoint;

/** 月报图Y轴数据*/
@property (nonatomic, strong) NSArray *monthYPoint;
/** 所有睡眠数据*/
@property(nonatomic,strong) NSMutableArray *monthTotalSleepArray;
/** 深睡眠数据*/
@property(nonatomic,strong) NSMutableArray *monthDeepSleepArray;
/** 月报图改变后数据*/
@property (nonatomic, strong) NSArray *monthChangeDataArray;
@end

@implementation HMSMonitorVC
{
    BOOL _isMonthReport;
}
-(NSMutableArray *)heartBeartDataArray
{
    if (!_heartBeartDataArray) {
        _heartBeartDataArray = [NSMutableArray array];
    }
    return _heartBeartDataArray;
}
-(NSMutableArray *)heartBeartTimeArray
{
    if (!_heartBeartTimeArray) {
        _heartBeartTimeArray = [NSMutableArray array];
    }
    return _heartBeartTimeArray;
}
-(NSMutableArray *)breathDataArray
{
    if (!_breathDataArray) {
        _breathDataArray = [NSMutableArray array];
    }
    return _breathDataArray;
}
-(NSMutableArray *)breathTimeArray
{
    if (!_breathTimeArray) {
        _breathTimeArray = [NSMutableArray array];
    }
    return _breathTimeArray;
}
-(NSMutableArray *)bodyMoveDataArray
{
    if (!_bodyMoveDataArray) {
        _bodyMoveDataArray = [NSMutableArray array];
    }
    return _bodyMoveDataArray;
}
-(NSMutableArray *)bodyMoveTimeArray
{
    if (!_bodyMoveTimeArray) {
        _bodyMoveTimeArray = [NSMutableArray array];
    }
    return _bodyMoveTimeArray;
}
-(NSMutableArray *)monthTotalSleepArray
{
    if (!_monthTotalSleepArray) {
        _monthTotalSleepArray = [NSMutableArray array];
    }
    return _monthTotalSleepArray;
}
-(NSMutableArray *)monthDeepSleepArray
{
    if (!_monthDeepSleepArray) {
        _monthDeepSleepArray = [NSMutableArray array];
    }
    return _monthDeepSleepArray;
}

-(NSMutableArray<HMSOldManModel *> *)oldManArray
{
    if (!_oldManArray) {
        _oldManArray = [NSMutableArray array];
    }
    return _oldManArray;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
    WS(ws);
    [self loadAllOldManSuccess:^{
        [ws.collectionView reloadData];
    }failure:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heartBeartYPoint =@[@60,@70,@80,@90,@100,@110,@120];
    self.breathYPoint = @[@5,@10,@15,@20,@25,@30,@35];
    self.bodyMoveYPoint = @[@5,@10,@15,@20,@25,@30,@35,@40];
    self.monthYPoint =@[@2,@4,@6,@8,@10,@12];
    
     WS(ws);
    _isMonthReport = NO;
    [self loadAllOldManSuccess:^{
        [ws.collectionView reloadData];
        ws.currentDayStr = ws.dateSelectView.dateString;
        [ws loadDayReportWithOldMan_id:ws.currentOldManID dayString:ws.currentDayStr];
        
    } failure:nil];
    
    self.view.backgroundColor = HMSThemeBackgroundColor;
    [self initView];
    
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(relodata) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)relodata
{
    NSInteger a = arc4random_uniform(100);
    NSInteger b = arc4random_uniform(30);
    NSInteger c = arc4random_uniform(60);
    
    self.realTimeView.heartRateLabel.text = [NSString stringWithFormat:@"%d",a];
    self.realTimeView.breatheLabel.text = [NSString stringWithFormat:@"%d",b];
    self.realTimeView.bodyMoveLabel.text = [NSString stringWithFormat:@"%d",c];
}

-(void)initView
{
    UIImageView *backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,64+ 186)];
    backImageView.image = [UIImage imageNamed:@"homePage_banner"];
    [self.view addSubview:backImageView];
    
    self.topLabel =[UILabel labelWithTitle:@"监测" Color:[UIColor whiteColor] Font:iPhone5_5s?HMSFOND(18):HMSFOND(19) textAlignment:NSTextAlignmentCenter] ;
    self.topLabel.frame =CGRectMake(70, 20, KScreenWidth-140, 44);
    [self.view addSubview:self.topLabel];
    
    self.contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64-49)];
    self.contentView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.contentView];
    
    self.garyBGView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    self.garyBGView.backgroundColor =HMSThemeBackgroundColor;
    [self.garyBGView setAutoresizesSubviews:NO];
    [self.contentView addSubview:self.garyBGView];
    
    
    UIImageView *imageBGView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 186)];
    imageBGView.image = [UIImage imageNamed:@"homePage_bannerTwo"];
    [self.garyBGView addSubview:imageBGView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(290, 120);
    layout.minimumInteritemSpacing = 12;
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 16, KScreenWidth, 120) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMSHomePageOldManCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HMSHomePageOldManCollectionCell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 12);
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.showsHorizontalScrollIndicator =NO;
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    [self.garyBGView addSubview:self.collectionView];
    
    
    self.realTimeView =[HMSMonitorRealTimeView monitorRealTimeView];
    self.realTimeView.frame = CGRectMake(12, CGRectGetMaxY(imageBGView.frame)+12, KScreenWidth-24, 190);
    [self.garyBGView addSubview:self.realTimeView];
    
    self.dateSelectView = [[HMSDateSelectView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(self.realTimeView.frame)+12, self.realTimeView.width, 50)];
    self.dateSelectView.delegate =self;
    [self.garyBGView addSubview:self.dateSelectView];
    
    self.dayReportView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(self.dateSelectView.frame), self.dateSelectView.width, 0)];
    [self.garyBGView addSubview:self.dayReportView];
    [self.dayReportView setAutoresizesSubviews:NO];
    
    self.dayReportOneViwe =[HMSMonitorDayReportOneView monitorDayReportOneView];
    self.dayReportOneViwe.frame = CGRectMake(0, 0,  KScreenWidth-24, 310);
    [self.dayReportView addSubview:self.dayReportOneViwe];
    
    HMSMonitorSleepProportionView *sleepProportionView = [[HMSMonitorSleepProportionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dayReportOneViwe.frame)+12, self.dayReportView.width, 310)];
    [self.dayReportView addSubview:sleepProportionView];
    
    self.sleepSubsectionView =[[HMSSleepSubsectionView alloc]initWithFrame:CGRectMake(0, 20, sleepProportionView.width, 215)];
    [sleepProportionView addSubview:self.sleepSubsectionView];
    
    CGFloat labelWidth =sleepProportionView.width / 4;
    NSArray *colorArray = @[UIColorFromRGB(0x0d47a1),UIColorFromRGB(0x1976d2),UIColorFromRGB(0x64b5f6),UIColorFromRGB(0x8e9fa8)];
    NSArray *titleArray = @[@"深睡眠",@"浅睡眠",@"REM",@"清醒"];
    for (int i =0; i<colorArray.count; i++) {
        CGSize titleSize = [titleArray[i] mh_sizeWithFont:HMSFOND(12) limitSize:CGSizeMake(labelWidth, 12)];
        UILabel *label = [UILabel labelWithTitle:titleArray[i] Color:[UIColor darkGrayColor] Font:HMSFOND(12) textAlignment:NSTextAlignmentCenter];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.sleepSubsectionView.frame)+18, titleSize.width, 12);
        label.centerX =labelWidth*i+labelWidth*0.5;
        [sleepProportionView addSubview:label];
        UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(label.x-8-5, 0, 5, 5)];
        titleView.layer.cornerRadius= 2.5;
        titleView.backgroundColor =colorArray[i];
        titleView.centerY =label.centerY;
        [sleepProportionView addSubview:titleView];
    }
    
    self.cycleView = [HMSMonitorCycleView monitorCycleView];
    self.cycleView.frame =CGRectMake(0, CGRectGetMaxY(sleepProportionView.frame), self.dayReportView.width, 125);
    [self.dayReportView addSubview:self.cycleView];
    
    UIView *heartRateBGView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleView.frame)+12, self.dayReportView.width, 250)];
    heartRateBGView.backgroundColor = [UIColor whiteColor];
    heartRateBGView.layer.cornerRadius = 3;
    heartRateBGView.clipsToBounds =YES;
    [self.dayReportView addSubview:heartRateBGView];
    
    UILabel *heartRateTitle = [UILabel labelWithTitle:@"平均心率" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    CGSize heartRateTitleSize = [heartRateTitle.text mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(250, 15)];
    heartRateTitle.frame = (CGRect){{20,20},heartRateTitleSize};
    [heartRateBGView addSubview:heartRateTitle];
    
    self.heartRateLabel = [UILabel labelWithTitle:@"0次/分" Color:[UIColor darkGrayColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    self.heartRateLabel.frame = (CGRect){{20,CGRectGetMaxY(heartRateTitle.frame)+12},{150,15}};
    [heartRateBGView addSubview:self.heartRateLabel];
    
    self.heartRateChartView = [self chartViewWithFtame:CGRectMake(0, CGRectGetMaxY(self.heartRateLabel.frame), heartRateBGView.width, heartRateBGView.height-20-CGRectGetMaxY(self.heartRateLabel.frame)) yPoint:self.heartBeartYPoint tag:1001];
    [heartRateBGView addSubview:self.heartRateChartView];
    
    UIView *breathRateBGView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heartRateBGView.frame)+12, self.dayReportView.width, 250)];
    breathRateBGView.backgroundColor = [UIColor whiteColor];
    breathRateBGView.layer.cornerRadius = 3;
    breathRateBGView.clipsToBounds =YES;
    [self.dayReportView addSubview:breathRateBGView];
    
    UILabel *breathRateTitle = [UILabel labelWithTitle:@"平均呼吸频率" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    CGSize breathRateTitleSize = [breathRateTitle.text mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(250, 15)];
    breathRateTitle.frame = (CGRect){{20,20},breathRateTitleSize};
    [breathRateBGView addSubview:breathRateTitle];
    
    self.breathRateLabel = [UILabel labelWithTitle:@"0次/分" Color:[UIColor darkGrayColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    self.breathRateLabel.frame = (CGRect){{20,CGRectGetMaxY(heartRateTitle.frame)+12},{150,15}};
    [breathRateBGView addSubview:self.breathRateLabel];
    
    self.breathRateChartView = [self chartViewWithFtame:CGRectMake(0, CGRectGetMaxY(self.breathRateLabel.frame), heartRateBGView.width, heartRateBGView.height-20-CGRectGetMaxY(self.breathRateLabel.frame)) yPoint:self.breathYPoint tag:1002];
    [breathRateBGView addSubview:self.breathRateChartView];
    
    
    UIView *bodyMoveBGView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(breathRateBGView.frame)+12, self.dayReportView.width, 250)];
    bodyMoveBGView.backgroundColor = [UIColor whiteColor];
    bodyMoveBGView.layer.cornerRadius = 3;
    bodyMoveBGView.clipsToBounds =YES;
    [self.dayReportView addSubview:bodyMoveBGView];
    
    UILabel *bodyMoveTitle = [UILabel labelWithTitle:@"体动" Color:[UIColor blackColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    CGSize bodyMoveTitleSize = [bodyMoveTitle.text mh_sizeWithFont:HMSFOND(15) limitSize:CGSizeMake(250, 15)];
    bodyMoveTitle.frame = (CGRect){{20,20},bodyMoveTitleSize};
    [bodyMoveBGView addSubview:bodyMoveTitle];
    
    self.bodyMoveLabel = [UILabel labelWithTitle:@"0次" Color:[UIColor darkGrayColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    self.bodyMoveLabel.frame = (CGRect){{20,CGRectGetMaxY(bodyMoveTitle.frame)+12},{150,15}};
    [bodyMoveBGView addSubview:self.bodyMoveLabel];
    
    self.bodyMoveChartView = [self chartViewWithFtame:CGRectMake(0, CGRectGetMaxY(self.bodyMoveLabel.frame), heartRateBGView.width, heartRateBGView.height-20-CGRectGetMaxY(self.bodyMoveLabel.frame)) yPoint:self.bodyMoveYPoint tag:1003];
    [bodyMoveBGView addSubview:self.bodyMoveChartView];
    
    
    self.dayReportView.height =CGRectGetMaxY(bodyMoveBGView.frame)+12;
    self.garyBGView.height = CGRectGetMaxY(self.dayReportView.frame);
    self.contentView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.garyBGView.frame));
    
    
    self.monthReportView = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth + 12, CGRectGetMaxY(self.dateSelectView.frame), self.dateSelectView.width, 0)];
    [self.monthReportView setAutoresizesSubviews:NO];
    [self.garyBGView addSubview:self.monthReportView];
    
    UIView *monthBGView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.monthReportView.width, 0)];
    monthBGView.backgroundColor = [UIColor whiteColor];
    [self.monthReportView addSubview:monthBGView];
    
    
    self.monthChartView =[self chartViewWithFtame:CGRectMake(0, 0, monthBGView.width, 290) yPoint:self.monthYPoint tag:1004];
    [monthBGView addSubview:self.monthChartView];
    
    UILabel *sleepTotalLabel = [UILabel labelWithTitle:@"睡眠时长" Color:[UIColor grayColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentLeft];
    CGSize sleepTotalLabelSize =[sleepTotalLabel.text mh_sizeWithFont:HMSFOND(13) limitSize:CGSizeMake(200, 15)];
    sleepTotalLabel.frame = (CGRect){{35,CGRectGetMaxY(self.monthChartView.frame)+20},{sleepTotalLabelSize.width,15}};
    [monthBGView addSubview:sleepTotalLabel];
    
    UIView *sleepTotalView = [[UIView alloc]initWithFrame:CGRectMake(sleepTotalLabel.x-8-3, 0, 5, 5)];
    sleepTotalView.layer.cornerRadius=2.5;
    sleepTotalView.clipsToBounds = YES;
    sleepTotalView.centerY =sleepTotalLabel.centerY;
    sleepTotalView.backgroundColor =UIColorFromRGB(0x64b5f6);
    [monthBGView addSubview:sleepTotalView];
    
    
    UILabel *sleepDeepLabel = [UILabel labelWithTitle:@"深睡眠时长" Color:[UIColor grayColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentLeft];
    CGSize sleepDeepLabelSize =[sleepDeepLabel.text mh_sizeWithFont:HMSFOND(13) limitSize:CGSizeMake(200, 15)];
    sleepDeepLabel.frame = (CGRect){{CGRectGetMaxX(sleepTotalLabel.frame)+50,CGRectGetMaxY(self.monthChartView.frame)+20},{sleepDeepLabelSize.width,15}};
    [monthBGView addSubview:sleepDeepLabel];
    
    UIView *sleepDeepView = [[UIView alloc]initWithFrame:CGRectMake(sleepDeepLabel.x-8-3, 0, 5, 5)];
    sleepDeepView.layer.cornerRadius=2.5;
    sleepDeepView.clipsToBounds = YES;
    sleepDeepView.centerY =sleepDeepLabel.centerY;
    sleepDeepView.backgroundColor =UIColorFromRGB(0x1976d2);
    [monthBGView addSubview:sleepDeepView];
    
    UIView *dividerView =[[UIView alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(sleepDeepLabel.frame)+15, monthBGView.width-4, 1)];
    dividerView.backgroundColor = HMSThemeDeviderColor;
    [monthBGView addSubview:dividerView];
    
    UILabel *avgDeepSleepTitle = [UILabel labelWithTitle:@"平均深睡眠时间" Color:[UIColor grayColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentLeft];
    CGSize avgDeepSleepTitleSize =[avgDeepSleepTitle.text mh_sizeWithFont:HMSFOND(13) limitSize:CGSizeMake(200, 15)];
    avgDeepSleepTitle.frame =(CGRect){{20,CGRectGetMaxY(dividerView.frame)+15},{avgDeepSleepTitleSize.width,15}};
    [monthBGView addSubview:avgDeepSleepTitle];
    
    self.avgDeepSleep = [UILabel labelWithTitle:@"0%" Color:[UIColor grayColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    CGFloat avgDeepSleepX = CGRectGetMaxX(avgDeepSleepTitle.frame)+15;
    self.avgDeepSleep.frame =CGRectMake(avgDeepSleepX, avgDeepSleepTitle.y, monthBGView.width-20-avgDeepSleepX, 15);
    [monthBGView addSubview:self.avgDeepSleep];
    
    self.bestSleepTitle = [UILabel labelWithTitle:@"最好睡眠质量" Color:[UIColor grayColor] Font:HMSFOND(13) textAlignment:NSTextAlignmentLeft];
    self.bestSleepTitle.frame =(CGRect){{20,CGRectGetMaxY(avgDeepSleepTitle.frame)+15},{avgDeepSleepTitle.width,15}};
    [monthBGView addSubview:self.bestSleepTitle];
    
    self.bestSleep = [UILabel labelWithTitle:@"" Color:[UIColor grayColor] Font:HMSFOND(15) textAlignment:NSTextAlignmentLeft];
    self.bestSleep.frame =CGRectMake(avgDeepSleepX, self.bestSleepTitle.y, self.avgDeepSleep.width, 15);
    [monthBGView addSubview:self.bestSleep];
    
    monthBGView.height =CGRectGetMaxY(self.bestSleepTitle.frame)+20;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:monthBGView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = monthBGView.bounds;
    maskLayer.path = maskPath.CGPath;
    monthBGView.layer.mask = maskLayer;
    
    self.monthReportView.height = CGRectGetMaxY(monthBGView.frame)+12;
    
}


//刷新日报数据
- (void)updateGraph {

    NSArray *(^ProducePointsA)(NSArray *) = ^(NSArray * array) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        NSArray *points = [WYLineChartPoint pointsFromValueArray:array];
        
        [mutableArray addObject:points];
        return mutableArray;
    };
    
    self.heartBeartChangeDataArray =ProducePointsA(self.heartBeartDataArray);
    self.heartRateChartView.points = [NSArray arrayWithArray:self.heartBeartChangeDataArray];
    
    [self.heartRateChartView updateGraph];
    self.heartRateLabel.text = [NSString stringWithFormat:@"%@次/分",self.currentDayReport.heart_beat_avg];
    
    self.breathChangeDataArray = ProducePointsA(self.breathDataArray);
    self.breathRateChartView.points = [NSArray arrayWithArray:self.breathChangeDataArray];
    [self.breathRateChartView updateGraph];
    self.breathRateLabel.text = [NSString stringWithFormat:@"%@次/分",self.currentDayReport.breath_avg];
    
    self.bodyMoveChangeDataArray = ProducePointsA(self.bodyMoveDataArray);
    self.bodyMoveChartView.points = [NSArray arrayWithArray:self.bodyMoveChangeDataArray];
    [self.bodyMoveChartView updateGraph];
    self.bodyMoveLabel.text = [NSString stringWithFormat:@"%@次",self.currentDayReport.body_move_times];
    
    self.sleepSubsectionView.dayReportM = self.currentDayReport;
    self.dayReportOneViwe.dayReportM = self.currentDayReport;
    self.cycleView.dayReportM = self.currentDayReport;
    
    if (!self.currentDayReport) {
         self.heartRateLabel.text = @"0次/分";
        self.breathRateLabel.text = @"0次/分";
        self.bodyMoveLabel.text = @"0次";
    }
}

//刷新月报数据
- (void)updateMonthGraph
{
    NSArray *(^ProducePointsA)() = ^() {
        NSMutableArray *mutableArray = [NSMutableArray array];
        NSArray *points = [WYLineChartPoint pointsFromValueArray:self.monthTotalSleepArray];
        [mutableArray addObject:points];
        points = [WYLineChartPoint pointsFromValueArray:self.monthDeepSleepArray];
        [mutableArray addObject:points];
        return mutableArray;
    };
    
    self.monthChangeDataArray =ProducePointsA();
    self.monthChartView.points = [NSArray arrayWithArray:self.monthChangeDataArray];
    
    [self.monthChartView updateGraph];
    
    self.avgDeepSleep.text =[NSString stringWithFormat:@"%@%%",self.currentMonthReport.deep_percentage_avg];
    self.bestSleep.text =self.currentMonthReport.best_day;

    
}

#pragma mark 生产WYLineChartView
-(WYLineChartView *)chartViewWithFtame:(CGRect)frame yPoint:(NSArray *)yPoint tag:(NSInteger)tag
{
    WYLineChartView *chartView =[[WYLineChartView alloc]initWithFrame:frame];
    chartView.delegate =self;
    chartView.datasource =self;
    
    chartView.labelsFont = [UIFont systemFontOfSize:9];
    chartView.axisColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    chartView.labelsColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    chartView.verticalReferenceLineColor = HMSCustomColor(236, 236, 236);
    chartView.animationDuration =2.0;
    chartView.animationStyle = kWYLineChartAnimationDrawing;
    chartView.backgroundColor = [UIColor whiteColor];
    
    
    chartView.scrollable = YES;
    chartView.pinchable = NO;
    chartView.yPoint =yPoint;
    chartView.tag =tag;
    
    if (tag==1004) {
        chartView.myType =WYLineChartViewTypeTwo;
    }else
    {
        chartView.myType =WYLineChartViewTypeOne;
    }
    
    return chartView;
}



-(void)loadDayReportWithOldMan_id:(NSString *)oldManID dayString:(NSString *)dayString
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"member_id"]=oldManID;
    params[@"date"]=dayString;
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"report/get-report-daily" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
           [self.heartBeartDataArray removeAllObjects];
            [self.heartBeartTimeArray removeAllObjects];
            [self.breathDataArray removeAllObjects];
            [self.breathTimeArray removeAllObjects];
            [self.bodyMoveDataArray removeAllObjects];
            [self.bodyMoveTimeArray removeAllObjects];
            
            self.currentDayReport = [HMSDayReportModel mj_objectWithKeyValues:respondObj[@"data"]];
            for (HMSTemp_dataModel *dataM in self.currentDayReport.heart_beat_data) {
                [self.heartBeartDataArray addObject:@(dataM.value)];
                NSString *timeStr = [NSString stringWithFormat:@"%02ld:00",(long)[dataM.time integerValue]];
                [self.heartBeartTimeArray addObject:timeStr];
            }
            for (HMSTemp_dataModel *dataM  in self.currentDayReport.breath_data) {
                [self.breathDataArray addObject:@(dataM.value)];
                NSString *timeStr = [NSString stringWithFormat:@"%02ld:00",(long)[dataM.time integerValue]];
                [self.breathTimeArray addObject:timeStr];
            }
            for (HMSTemp_dataModel *dataM in self.currentDayReport.body_move_data) {
                [self.bodyMoveDataArray addObject:@(dataM.value)];
                NSString *timeStr = [NSString stringWithFormat:@"%02ld:00",(long)[dataM.time integerValue]];
                [self.bodyMoveTimeArray addObject:timeStr];
            }
            
            
            [self updateGraph];
        }else
        {
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
}

-(void)loadMonthReportWithOldMan_id:(NSString *)oldManID monthStr:(NSString *)monthStr
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"member_id"]=oldManID;
    params[@"date"]=monthStr;
    [SVProgressHUD show];
    [HMSNetWorkManager requestJsonDataWithPath:@"report/get-report-month" withParams:params withMethodType:HttpRequestTypeGet success:^(id respondObj) {
        [SVProgressHUD dismiss];
        NSString *error = [respondObj objectForKey:@"error"];
        NSString *error_message = [respondObj objectForKey:@"error_message"];
        if([error isEqualToString:@""]){
            [self.monthTotalSleepArray removeAllObjects];
            [self.monthDeepSleepArray removeAllObjects];
            
            self.currentMonthReport = [HMSMonthReportModel mj_objectWithKeyValues:respondObj[@"data"]];
            for (HMSMonth_sleep_dataModel *tmpM in self.currentMonthReport.month_sleep_data) {
                [self.monthTotalSleepArray addObject:@(tmpM.sleep_duration_minute==0?0:tmpM.sleep_duration_minute/60.0)];
                [self.monthDeepSleepArray addObject:@(tmpM.deep_duration_minute==0?0:tmpM.deep_duration_minute/60.0)];
            }
            
            [self updateMonthGraph];
        }else
        {
            [SVProgressHUD showErrorWithStatus:error_message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
    }];
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
            self.currentOldManID = [self.oldManArray firstObject].oldMan_id;
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


#pragma mark ---------------- HMSDateSelectViewDelegate---------------
-(void)dateSelectorViewDaySelect:(HMSDateSelectView *)selectorView withDateString:(NSString *)dateStr
{
    self.currentDayStr = dateStr;
    [self loadDayReportWithOldMan_id:self.currentOldManID dayString:self.currentDayStr];
}

-(void)dateSelectorViewMonthSelect:(HMSDateSelectView *)selectorView withMonthDateString:(NSString *)monthStr
{
    self.currentMonthStr =monthStr;
    [self loadMonthReportWithOldMan_id:self.currentOldManID monthStr:self.currentMonthStr];
}
-(void)dateSelectorViewChangeDayOrMonth:(HMSDateSelectView *)selectorView didChangeMonth:(BOOL)isMonth
{
    WS(ws);
    if (isMonth) {
        _isMonthReport =YES;
        [UIView animateWithDuration:0.3 animations:^{
            ws.dayReportView.x -= KScreenWidth;
            ws.monthReportView.x -= KScreenWidth;
        }completion:^(BOOL finished) {
            ws.garyBGView.height = CGRectGetMaxY(ws.monthReportView.frame);
            ws.contentView.contentSize = CGSizeMake(0, CGRectGetMaxY(ws.garyBGView.frame));
        }];
        
    }else
    {
        _isMonthReport =NO;
        [UIView animateWithDuration:0.3 animations:^{
            ws.dayReportView.x += KScreenWidth;
            ws.monthReportView.x += KScreenWidth;
        }completion:^(BOOL finished) {
            ws.garyBGView.height = CGRectGetMaxY(ws.dayReportView.frame);
            ws.contentView.contentSize = CGSizeMake(0, CGRectGetMaxY(ws.garyBGView.frame));
        }];
    }
    
}

-(void)dateSelectorViewDidClickShareBtn:(HMSDateSelectView *)selectorView
{
    HMSSharePopView *sharePopView = [[HMSSharePopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [sharePopView show];
    sharePopView.popViewSelectAction = ^(NSInteger tag){
        
#warning 分享朋友圈点击之后逻辑
    };
}


#pragma mark ---------------- UICollectionViewDelegate,DataSource---------------


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.oldManArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMSHomePageOldManCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HMSHomePageOldManCollectionCell" forIndexPath:indexPath];
    cell.oldManCardBtn.hidden =YES;
    cell.headerImgView.userInteractionEnabled =NO;
    cell.oldManM = self.oldManArray[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HMSOldManModel *oldMan = self.oldManArray[indexPath.row];
    self.currentOldManID = oldMan.oldMan_id;
    if (_isMonthReport) {
        [self loadMonthReportWithOldMan_id:self.currentOldManID monthStr:self.currentMonthStr];
    }else
    {
        [self loadDayReportWithOldMan_id:self.currentOldManID dayString:self.currentDayStr];
    }
    
}



#pragma mark --------------------- WYLineChartViewDelegate------------------------

- (NSInteger)numberOfLabelOnXAxisInLineChartView:(WYLineChartView *)chartView {
    
    return [chartView.points[0] count];

    
}

- (NSInteger)numberOfLabelOnYAxisInLineChartView:(WYLineChartView *)chartView {
     return chartView.yPoint.count;
    
}

- (CGFloat)gapBetweenPointsHorizontalInLineChartView:(WYLineChartView *)chartView {
    if (chartView.tag==1004) {
        return [chartView.points[0] count]*60>chartView.width?40:60;
    }
    return 60.f;
}

- (NSInteger)numberOfReferenceLineVerticalInLineChartView:(WYLineChartView *)chartView {
    return [chartView.points[0] count];
    
}



#pragma mark --------------------- WYLineChartViewDatasource-------------------------



- (NSString *)lineChartView:(WYLineChartView *)chartView contentTextForXAxisLabelAtIndex:(NSInteger)index {
    switch (chartView.tag) {
        case 1001:
            return self.heartBeartTimeArray[index];
            break;
        case 1002:
            return self.breathTimeArray[index];
            break;
        case 1003:
            return self.bodyMoveTimeArray[index];
            break;
        case 1004:
        {
            NSString *day =self.currentMonthReport.month_sleep_data[index].day;
            NSString *str =[HMSUtils weekdayStringFromDate:day];
            return [NSString stringWithFormat:@"%@-%@",str,[[day componentsSeparatedByString:@"-"] lastObject]];
        }
        default:
            break;
    }
    return 0;
    
}

- (WYLineChartPoint *)lineChartView:(WYLineChartView *)chartView pointReferToXAxisLabelAtIndex:(NSInteger)index {
   return chartView.points[0][index];
    
}

- (WYLineChartPoint *)lineChartView:(WYLineChartView *)chartView pointReferToVerticalReferenceLineAtIndex:(NSInteger)index {
    
   return chartView.points[0][index];
    
}

- (NSString *)lineChartView:(WYLineChartView *)chartView contentTextForYAxisLabelAtIndex:(NSInteger)index {
    
    return  [NSString stringWithFormat:@"%@",chartView.yPoint[index]];
    
    
}

- (CGFloat)lineChartView:(WYLineChartView *)chartView valueReferToYAxisLabelAtIndex:(NSInteger)index {
    return [chartView.yPoint[index] floatValue];
   
    
}



- (NSDictionary *)lineChartView:(WYLineChartView *)chartView attributesForLineAtIndex:(NSUInteger)index {
    //    NSDictionary *attribute = [_settingViewController getLineAttributesAtIndex:index];
    NSMutableDictionary *resultAttributes = [NSMutableDictionary dictionary];
    resultAttributes[kWYLineChartLineAttributeLineStyle] = @(kWYLineChartMainBezierWaveLine);
    resultAttributes[kWYLineChartLineAttributeDrawGradient] = @(true);
    resultAttributes[kWYLineChartLineAttributeJunctionStyle] = @(kWYLineChartJunctionShapeNone);
    
    UIColor *lineColor;
    switch (chartView.tag) {
        case 1001:
            lineColor =UIColorFromRGB(0xfb734f);
            break;
        case 1002:
            lineColor =UIColorFromRGB(0x28bdde);
            break;
        case 1003:
            lineColor =UIColorFromRGB(0x251e51);
            break;
        case 1004:
        {
            switch (index) {
                case 0:
                    lineColor =UIColorFromRGB(0x64b5f6);
                    break;
                case 1:
                    lineColor = UIColorFromRGB(0x1976d2);
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    resultAttributes[kWYLineChartLineAttributeLineColor] = lineColor;
    resultAttributes[kWYLineChartLineAttributeJunctionColor] = lineColor;
    
    return resultAttributes;
}


@end

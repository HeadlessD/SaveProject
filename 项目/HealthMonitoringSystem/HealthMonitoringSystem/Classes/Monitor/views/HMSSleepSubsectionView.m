//
//  HMSSleepSubsectionView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/28.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSleepSubsectionView.h"
#import "HMSDayReportModel.h"

/**  Cell边距 */
NSInteger const HMSAwakY = 50;
NSInteger const HMSAwakHeight = 50;
NSInteger const HMSDeepY = 15;
NSInteger const HMSDeepHeight = 120;
NSInteger const HMSlightY = 25;
NSInteger const HMSlightHeight = 100;
NSInteger const HMSRemY = 40;
NSInteger const HMSRemHeight = 70;

@interface HMSSleepSubsectionView ()
@property (nonatomic,strong) NSMutableArray *timeDataArray;

@property (nonatomic,strong) NSString *minDateStr;
@property (nonatomic,strong) NSString *maxDateStr;

@property (nonatomic,assign) NSInteger starHour;
@property (nonatomic,assign) NSInteger endHour;
@end
@implementation HMSSleepSubsectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor= [UIColor whiteColor];
    }
    return self;
}
-(NSMutableArray *)timeDataArray
{
    if (!_timeDataArray) {
        _timeDataArray = [NSMutableArray array];
    }
    return _timeDataArray;
}

-(void)setDayReportM:(HMSDayReportModel *)dayReportM
{
    _dayReportM = dayReportM;
    
    if (dayReportM.sleep_data.count>2) {
        [self.timeDataArray removeAllObjects];
        NSString *minDataString =[self dateStrWithTimeInterval:[dayReportM.sleep_data firstObject].start];
        NSString *maxDataString =[self dateStrWithTimeInterval:[dayReportM.sleep_data lastObject].end];
        
        NSArray *minDateAttay = [[[minDataString componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"];
        NSArray *maxDateAttay = [[[maxDataString componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"];
        
        NSInteger starHour = [[minDateAttay firstObject] integerValue];
        NSInteger endHour;
        if ([maxDateAttay[1] integerValue]>0) {
            endHour =[[maxDateAttay firstObject] integerValue]+1;
        }else{
            endHour =[[maxDateAttay firstObject] integerValue];
        }
        self.starHour = starHour;
        self.endHour = endHour;
        NSArray *minDateArray  =@[[[minDataString componentsSeparatedByString:@" "] firstObject],[NSString stringWithFormat:@"%ld:00:00",starHour]];
        NSArray *maxDateArray  =@[[[maxDataString componentsSeparatedByString:@" "] firstObject],[NSString stringWithFormat:@"%ld:00:00",endHour]];
        self.minDateStr = [minDateArray componentsJoinedByString:@" "];
        self.maxDateStr = [maxDateArray componentsJoinedByString:@" "];
        
        for (NSInteger i = starHour,j=starHour; i<=((endHour<=24&&endHour>starHour)?endHour:(24+endHour)); i++,j++) {
            [self.timeDataArray addObject:@(j)];
            if (j==24) {
                j=0;
            }
        }
        
        
        [self setNeedsDisplay];
    }
}

-(void)initRectWithRect:(CGRect)rect color:(UIColor *)color{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(x,y, width, height)];
    CAShapeLayer *rectLayer = [[CAShapeLayer alloc]init];
    rectLayer.fillColor = color.CGColor;
    rectLayer.path = rectPath.CGPath;
    UIBezierPath *path;
    if (width>4) {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x,y, width, height) byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft|UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)];
        rectLayer.path = path.CGPath;
    }
    [self.layer addSublayer:rectLayer];
}
-(void)initLineWithRect:(CGRect)rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, width, height)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.fillColor = [UIColor colorWithRed:36 / 255.0 green:209 / 255.0 blue: 211 / 255.0 alpha:1].CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
}

-(CGFloat)xWithStarTimeInterval:(NSString *)timeInterVal
{
    NSTimeInterval time=[timeInterVal doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:self.minDateStr];
    
    NSTimeInterval difference =  [detaildate timeIntervalSinceDate:date];
    
   return self.width*difference /((self.timeDataArray.count-1)*60*60);
    
}

-(CGFloat)widthWithStarTimeInterval:(NSString *)starTime endTimeInterval:(NSString *)end
{
    NSTimeInterval timeOne=[starTime doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate*dateOne=[NSDate dateWithTimeIntervalSince1970:timeOne];
    
    NSTimeInterval timeTwo=[end doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate*dateTwo=[NSDate dateWithTimeIntervalSince1970:timeTwo];
    
    NSTimeInterval difference =  [dateTwo timeIntervalSinceDate:dateOne];
    
    return self.width*difference /((self.timeDataArray.count-1)*60*60);
}

-(NSString *)dateStrWithTimeInterval:(NSString *)timeInterval
{
  
    NSTimeInterval time=[timeInterval doubleValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSLog(@"date:%@",[detaildate description]);
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
}
-(NSString *)timeIntervalWithDateStr:(NSString *)dateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:dateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeSp;
}

//时间秒数
-(NSUInteger)secondWithTime:(NSString *)time{
    NSString *startHour = [time substringToIndex:2];
    NSString *startMinutes = [time substringFromIndex:3];
    NSInteger second = ([startHour integerValue] * 60 * 60) + ([startMinutes integerValue] * 60);
    return second;
}

-(void)drawRect:(CGRect)rect
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    CGFloat lineMargin = self.width / (self.timeDataArray.count-1);
    
    for (HMSSleep_dataModel *sleepData in self.dayReportM.sleep_data) {
        switch (sleepData.status) {
            case 1://1:deep
            {
                CGFloat x = [self xWithStarTimeInterval:sleepData.start];
                CGFloat w = [self widthWithStarTimeInterval:sleepData.start endTimeInterval:sleepData.end];
                CGRect rect = CGRectMake(x, HMSDeepY, w, HMSDeepHeight);
                [self initRectWithRect:rect color:UIColorFromRGB(0x0d47a1)];
            }
                break;
            case 2://2:light
            {
                CGFloat x = [self xWithStarTimeInterval:sleepData.start];
                CGFloat w = [self widthWithStarTimeInterval:sleepData.start endTimeInterval:sleepData.end];
                CGRect rect = CGRectMake(x, HMSlightY, w, HMSlightHeight);
                [self initRectWithRect:rect color:UIColorFromRGB(0x1976d2)];
            }
                break;
            case 3://3:rem
            {
                CGFloat x = [self xWithStarTimeInterval:sleepData.start];
                CGFloat w = [self widthWithStarTimeInterval:sleepData.start endTimeInterval:sleepData.end];
                CGRect rect = CGRectMake(x, HMSRemY, w, HMSRemHeight);
                [self initRectWithRect:rect color:UIColorFromRGB(0x64b5f6)];
            }
                break;
            case 4://4:wake
            {
                CGFloat x = [self xWithStarTimeInterval:sleepData.start];
                CGFloat w = [self widthWithStarTimeInterval:sleepData.start endTimeInterval:sleepData.end];
                CGRect rect = CGRectMake(x, HMSAwakY, w, HMSAwakHeight);
                [self initRectWithRect:rect color:UIColorFromRGB(0x8e9fa8)];
            }
                break;
                
            default:
                break;
        }
        
    }
    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, self.width, self.height *0.5)];
    maskView.backgroundColor =[UIColor colorWithWhite:1 alpha:0.5];
    [self addSubview:maskView];
    
    for (HMSSleep_dataModel *sleepData in self.dayReportM.sleep_data) {
        if (sleepData.status==5) {
            CGFloat startx = [self xWithStarTimeInterval:sleepData.start];
            CGFloat endx = [self xWithStarTimeInterval:sleepData.end];
            [self initRectWithRect:CGRectMake(startx, HMSDeepY, 0.5, HMSDeepHeight) color:UIColorFromRGB(0x28bdde)];
            [self initRectWithRect:CGRectMake(endx, HMSDeepY, 0.5, HMSDeepHeight) color:UIColorFromRGB(0x28bdde)];
            
            UIImageView *leaveBedImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, HMSlightY+HMSDeepHeight+5, 20, 20)];
            leaveBedImg.image =[UIImage imageNamed:@"monitor_leaveBed"];
            leaveBedImg.centerX = startx +(endx -startx)*0.5;
            [self addSubview:leaveBedImg];
        }
    }
    
    
    
    
    
    CGSize  maxSize= [@"00:00" mh_sizeWithFont:HMSFOND(9) limitSize:CGSizeMake(200, 9)];
    for (int i =0; i<self.timeDataArray.count; i++) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%02ld:00",(long)[self.timeDataArray[i] integerValue]];
        UILabel *timeLabel = [UILabel labelWithTitle:timeStr Color:[UIColor colorWithWhite:0.7 alpha:1.0] Font:HMSFOND(9) textAlignment:NSTextAlignmentCenter];
        timeLabel.size = maxSize;
        timeLabel.y = 188;
        timeLabel.centerX =lineMargin*i;
        if (i==0) {
            timeLabel.x = 0;
            timeLabel.textAlignment =NSTextAlignmentLeft;
        }
        if (i==(self.timeDataArray.count-1)) {
            timeLabel.x = self.width-timeLabel.width;
            timeLabel.textAlignment =NSTextAlignmentRight;
        }
        NSInteger hourCount = self.timeDataArray.count-1;
        if (hourCount<7) {
            [self addSubview:timeLabel];
        }else if (hourCount<18)
        {
            if (!(i%2)) {
               [self addSubview:timeLabel];
            }
            
        }else
        {
            if (!(i%3)) {
                [self addSubview:timeLabel];
            }
        }
        
        
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(ctx);
        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx,  HMSCustomColor(236, 236, 236).CGColor);
        CGContextMoveToPoint(ctx, lineMargin*i , 180);
        CGContextAddLineToPoint(ctx, lineMargin*i , 185);
        CGContextStrokePath(ctx);
        
        CGContextRef ctx1 = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(ctx1);
        CGContextSetLineWidth(ctx1, 1);
        CGContextSetStrokeColorWithColor(ctx1,  HMSCustomColor(236, 236, 236).CGColor);
        CGContextMoveToPoint(ctx1, lineMargin*i+lineMargin*0.5 , 180);
        CGContextAddLineToPoint(ctx1, lineMargin*i+lineMargin*0.5, 183);
        CGContextStrokePath(ctx1);
    }
    
    CGFloat starX,endX;
    if (self.starHour >=18) {
        starX = 0;
    }else
    {
       NSString *nightStar = [NSString stringWithFormat:@"%@ 18:00:00",[[self.minDateStr componentsSeparatedByString:@" "] firstObject]];
        starX = [self xWithStarTimeInterval:[self timeIntervalWithDateStr:nightStar]];
    }
    if (self.endHour>=6) {
        endX = self.width;
    }else
    {
         NSString *nightEnd = [NSString stringWithFormat:@"%@ 6:00:00",[[self.maxDateStr componentsSeparatedByString:@" "] firstObject]];
        endX = [self xWithStarTimeInterval:[self timeIntervalWithDateStr:nightEnd]];
    }
    if (endX>0) {
        starX +=1;
        endX -=1;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(ctx);
        CGContextSetLineWidth(ctx, 2);
        CGContextSetStrokeColorWithColor(ctx,  HMSThemeColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextMoveToPoint(ctx, starX , 209);
        CGContextAddLineToPoint(ctx, endX , 209);
        CGContextStrokePath(ctx);
        
        UIImageView *nightImgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 209-4, 8, 8)];
        nightImgView.image = [UIImage imageNamed:@"monitor_night_moon"];
        nightImgView.centerX = starX +(endX-starX)*0.5;
        [self addSubview:nightImgView];
    }
   
    
}
@end
